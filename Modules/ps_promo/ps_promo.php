<?php
/**
 * @Author: aslimani
 * @Author Email: anthonyslimani@orange.fr
 * @Date:   2017-03-28 09:51:32
 * @Project Name: ps_promo
 * @Path File: C:\Users\aslimani\Desktop\ps_promo\ps_promo.php
 * @File Name: ps_promo.php
 * @Last Modified by:   aslimani
 * @Last Modified time: 2017-03-28 10:05:18
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

use PrestaShop\PrestaShop\Core\Module\WidgetInterface;

class Ps_Promo extends Module implements WidgetInterface
{
    private $templateFile;

	public function __construct()
	{
		$this->name = 'ps_promo';
		$this->version = '1.0.0';
		$this->author = 'Projet3';
		$this->need_instance = 0;

        $this->bootstrap = true;
        parent::__construct();

        $this->displayName = $this->trans('Promotion', array(), 'Modules.Promo');
        $this->description = $this->trans('Displays a promotion banner on your shop.', array(), 'Modules.Promo');

        $this->ps_versions_compliancy = array('min' => '1.7.0.0', 'max' => _PS_VERSION_);

        $this->templateFile = 'module:ps_promo/ps_promo.tpl';
    }

    public function install()
    {
        return (parent::install() &&
            $this->registerHook('displayHome') &&
            $this->registerHook('actionObjectLanguageAddAfter') &&
            $this->installFixtures() &&
            $this->disableDevice(Context::DEVICE_MOBILE));
    }

    public function hookActionObjectLanguageAddAfter($params)
    {
        return $this->installFixture((int)$params['object']->id, Configuration::get('PROMO_IMG', (int)Configuration::get('PS_LANG_DEFAULT')));
    }

    protected function installFixtures()
    {
        $languages = Language::getLanguages(false);

        foreach ($languages as $lang) {
            $this->installFixture((int)$lang['id_lang'], 'sale70.png');
        }

        return true;
    }

    protected function installFixture($id_lang, $image = null)
    {
        $values['PROMO_IMG'][(int)$id_lang] = $image;
        $values['PROMO_LINK'][(int)$id_lang] = '';
        $values['PROMO_DESC'][(int)$id_lang] = '';

        Configuration::updateValue('PROMO_IMG', $values['PROMO_IMG']);
        Configuration::updateValue('PROMO_LINK', $values['PROMO_LINK']);
        Configuration::updateValue('PROMO_DESC', $values['PROMO_DESC']);
    }

    public function uninstall()
    {
        Configuration::deleteByName('PROMO_IMG');
        Configuration::deleteByName('PROMO_LINK');
        Configuration::deleteByName('PROMO_DESC');

        return parent::uninstall();
    }

    public function postProcess()
    {
        if (Tools::isSubmit('submitStoreConf')) {
            $languages = Language::getLanguages(false);
            $values = array();
            $update_images_values = false;

            foreach ($languages as $lang) {
                if (isset($_FILES['PROMO_IMG_'.$lang['id_lang']])
                    && isset($_FILES['PROMO_IMG_'.$lang['id_lang']]['tmp_name'])
                    && !empty($_FILES['PROMO_IMG_'.$lang['id_lang']]['tmp_name'])) {
                    if ($error = ImageManager::validateUpload($_FILES['PROMO_IMG_'.$lang['id_lang']], 4000000)) {
                        return $error;
                    } else {
                        $ext = substr($_FILES['PROMO_IMG_'.$lang['id_lang']]['name'], strrpos($_FILES['PROMO_IMG_'.$lang['id_lang']]['name'], '.') + 1);
                        $file_name = md5($_FILES['PROMO_IMG_'.$lang['id_lang']]['name']).'.'.$ext;

                        if (!move_uploaded_file($_FILES['PROMO_IMG_'.$lang['id_lang']]['tmp_name'], dirname(__FILE__).DIRECTORY_SEPARATOR.'img'.DIRECTORY_SEPARATOR.$file_name)) {
                            return $this->displayError($this->trans('An error occurred while attempting to upload the file.', array(), 'Admin.Notifications.Error'));
                        } else {
                            if (Configuration::hasContext('PROMO_IMG', $lang['id_lang'], Shop::getContext())
                                && Configuration::get('PROMO_IMG', $lang['id_lang']) != $file_name) {
                                @unlink(dirname(__FILE__) . DIRECTORY_SEPARATOR . 'img' . DIRECTORY_SEPARATOR . Configuration::get('PROMO_IMG', $lang['id_lang']));
                            }

                            $values['PROMO_IMG'][$lang['id_lang']] = $file_name;
                        }
                    }

                    $update_images_values = true;
                }

                $values['PROMO_LINK'][$lang['id_lang']] = Tools::getValue('PROMO_LINK_'.$lang['id_lang']);
                $values['PROMO_DESC'][$lang['id_lang']] = Tools::getValue('PROMO_DESC_'.$lang['id_lang']);
            }

            if ($update_images_values) {
                Configuration::updateValue('PROMO_IMG', $values['PROMO_IMG']);
            }

            Configuration::updateValue('PROMO_LINK', $values['PROMO_LINK']);
            Configuration::updateValue('PROMO_DESC', $values['PROMO_DESC']);

            $this->_clearCache($this->templateFile);

            return $this->displayConfirmation($this->trans('The settings have been updated.', array(), 'Admin.Notifications.Success'));
        }

        return '';
    }

    public function getContent()
    {
        return $this->postProcess().$this->renderForm();
    }

    public function renderForm()
    {
        $fields_form = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->trans('Settings', array(), 'Admin.Global'),
                    'icon' => 'icon-cogs'
                ),
                'input' => array(
                    array(
                        'type' => 'file_lang',
                        'label' => $this->trans('Promo image', array(), 'Modules.Promo'),
                        'name' => 'PROMO_IMG',
                        'desc' => $this->trans('Upload an image for your top banner. The recommended dimensions are 1110 x 214px if you are using the default theme.', array(), 'Modules.Promo'),
                        'lang' => true,
                    ),
                    array(
                        'type' => 'text',
                        'lang' => true,
                        'label' => $this->trans('Promo Link', array(), 'Modules.Promo'),
                        'name' => 'PROMO_LINK',
                        'desc' => $this->trans('Enter the link associated to your banner. When clicking on the banner, the link opens in the same window. If no link is entered, it redirects to the homepage.', array(), 'Modules.Promo')
                    ),
                    array(
                        'type' => 'text',
                        'lang' => true,
                        'label' => $this->trans('Promo description', array(), 'Modules.Promo'),
                        'name' => 'PROMO_DESC',
                        'desc' => $this->trans('Please enter a short but meaningful description for the banner.', array(), 'Modules.Promo')
                    )
                ),
                'submit' => array(
                    'title' => $this->trans('Save', array(), 'Admin.Actions')
                )
            ),
        );

        $lang = new Language((int)Configuration::get('PS_LANG_DEFAULT'));

        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $helper->default_form_language = $lang->id;
        $helper->module = $this;
        $helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') ? Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') : 0;
        $helper->identifier = $this->identifier;
        $helper->submit_action = 'submitStoreConf';
        $helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false).'&configure='.$this->name.'&tab_module='.$this->tab.'&module_name='.$this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->tpl_vars = array(
            'uri' => $this->getPathUri(),
            'fields_value' => $this->getConfigFieldsValues(),
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $this->context->language->id
        );

        return $helper->generateForm(array($fields_form));
    }

    public function getConfigFieldsValues()
    {
        $languages = Language::getLanguages(false);
        $fields = array();

        foreach ($languages as $lang) {
            $fields['PROMO_IMG'][$lang['id_lang']] = Tools::getValue('PROMO_IMG_'.$lang['id_lang'], Configuration::get('PROMO_IMG', $lang['id_lang']));
            $fields['PROMO_LINK'][$lang['id_lang']] = Tools::getValue('PROMO_LINK_'.$lang['id_lang'], Configuration::get('PROMO_LINK', $lang['id_lang']));
            $fields['PROMO_DESC'][$lang['id_lang']] = Tools::getValue('PROMO_DESC_'.$lang['id_lang'], Configuration::get('PROMO_DESC', $lang['id_lang']));
        }

        return $fields;
    }

    public function renderWidget($hookName, array $params)
    {
        if (!$this->isCached($this->templateFile, $this->getCacheId('ps_promo'))) {
            $this->smarty->assign($this->getWidgetVariables($hookName, $params));
        }

        return $this->fetch($this->templateFile, $this->getCacheId('ps_promo'));
    }

    public function getWidgetVariables($hookName, array $params)
    {
        $imgname = Configuration::get('PROMO_IMG', $this->context->language->id);

        if ($imgname && file_exists(_PS_MODULE_DIR_.$this->name.DIRECTORY_SEPARATOR.'img'.DIRECTORY_SEPARATOR.$imgname)) {
            $this->smarty->assign('promo_img', $this->context->link->protocol_content . Tools::getMediaServer($imgname) . $this->_path . 'img/' . $imgname);
        }

        $promo_link = Configuration::get('PROMO_LINK', $this->context->language->id);
        if (!$promo_link) {
            $promo_link = $this->context->link->getPageLink('index');
        }

        return array(
            'promo_link' => $promo_link,
            'promo_desc' => Configuration::get('PROMO_DESC', $this->context->language->id)
        );
    }
}
