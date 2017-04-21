{*
* 2017 Projet 3
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
*  @author Projet 3 <projet3@disii.fr>
*  @copyright  2017 Projet 3
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  Projet 3
*}
<a class="promo" href="{$promo_link}">
  {if isset($promo_img)}
    <img src="{$promo_img}" alt="{$promo_desc}" title="{$promo_desc}">
  {else}
    <span>{$promo_desc}</span>
  {/if}
</a>
