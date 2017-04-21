<?php
class promoModuleFrontController extends ModuleFrontController
{
  public function initContent()
  {
  	$this->context->smarty->assign('module_dir', 'promo');
    parent::initContent();
    $this->setTemplate('test.tpl');
  }
}