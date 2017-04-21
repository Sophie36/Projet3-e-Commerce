<?php
/**
* 2007-2017 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author    PrestaShop SA <contact@prestashop.com>
*  @copyright 2007-2017 PrestaShop SA
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

$sql = array();

// $sql[] = 'CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'promo` (
//     `id_promo` int(11) NOT NULL AUTO_INCREMENT,
//     PRIMARY KEY  (`id_promo`)
// ) ENGINE='._MYSQL_ENGINE_.' DEFAULT CHARSET=utf8;';

$sql[] = 'CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'promo_img` (
   `id_promo_slides` int(10) unsigned NOT NULL,
              `title` varchar(255) NOT NULL,
              `description` text NOT NULL,
              `legend` varchar(255) NOT NULL,
              `url` varchar(255) NOT NULL,
              `image` varchar(255) NOT NULL,
              `debut` varchar(255) NOT NULL,
              `fin` varchar(255) NOT NULL,
              PRIMARY KEY (`id_promo_slides`)
            ) ENGINE='._MYSQL_ENGINE_.' DEFAULT CHARSET=UTF8';

foreach ($sql as $query) {
    if (Db::getInstance()->execute($query) == false) {
        return false;
    }
}
