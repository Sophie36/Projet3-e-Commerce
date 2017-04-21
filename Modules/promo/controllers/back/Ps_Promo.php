<?php
/**
 * @Author: aslimani
 * @Author Email: anthonyslimani@orange.fr
 * @Date:   2017-04-04 13:20:25
 * @Project Name: promo
 * @Path File: C:\Users\aslimani\Desktop\promo\controllers\back\Ps_Promo.php
 * @File Name: Ps_Promo.php
 * @Last Modified by:   aslimani
 * @Last Modified time: 2017-04-04 13:20:57
 */

class Ps_Promo extends ObjectModel
{
	public function add($autodate = true, $null_values = false)
	{
		$context = Context::getContext();
		$id_shop = $context->shop->id;

		$res = parent::add($autodate, $null_values);
		$res &= Db::getInstance()->execute('
			INSERT INTO `'._DB_PREFIX_.'homeslider` (`id_shop`, `id_homeslider_slides`)
			VALUES('.(int)$id_shop.', '.(int)$this->id.')'
			);
		return $res;
	}

}