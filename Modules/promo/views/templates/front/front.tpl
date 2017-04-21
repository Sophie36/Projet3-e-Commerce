{*
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
	*}

<!-- Appel du JS nécessaire à l'affichage du slider -->
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
	<script src="../modules/promo/views/js/responsiveslides.min.js"></script>


<!-- Début de la div du Slider Promotion -->
	<div class="panel">
		<div class="callbacks_container">
			<ul class="rslides" id="slider4">
				{foreach from=$slides item=slide}
				{if $slide.debut <= $date AND $slide.fin >= $date}
				<li>
					<a href="{$slide.url}"><img src="{$slide.image_url}" alt="{$slide.description}"></a>
					<p class="caption">Code : {$slide.title}
<!-- 						<br />
						 -->
					</p>
				</li>
				{else}

				{/if}
				{/foreach}
			</div>
			
		</div>
<!-- Fin de la div du Slider Promotion -->

<!-- Appel de paramètre pour l'affichage du slider et paramètres sur le redimensionnement de la fenêtre hôte -->
		{literal}
		<script>

// Permet de cacher ou non le bandeau sur chaque slider en fonction du point de rupture d'une fenêtre
			window.onresize = function() {
				var largeur = $(window).width();

				if(largeur < 599){

					$('.caption').hide();
				}else{
					$('.caption').show();
				}
			}

// Paramètres du slider courant
			$(function() {
				$("#slider4").responsiveSlides({
					auto: true,
					pager: true,
					nav: true,
					speed: 500,
					timeout: 4000,
					namespace: "centered-btns"
				});
			});
		</script>
		{/literal}