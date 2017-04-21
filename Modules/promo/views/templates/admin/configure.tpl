{**
	* 2007-2017 Projet 3
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
	*  @author    Projet 3 <projet3@projet.com>
	*  @copyright 20017-2018 Projet 3
	*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
	*  International Registered Trademark & Property of PrestaShop SA
	*}

	<!-- Début d'affichage des tables Code(s) Existant(s) et Slider(s) Créé(s) -->
	<div class="row">
		<div class="sidebar navigation col-md-3">
			<div class="panel">
				<h3><i class="icon icon-tags"></i> {l s='Code(s) existant(s)' mod='promo'}</h3>
				<nav class="list-group categorieList">
					<table id="tablecode" class="table table-striped">
						<thead>
							<tr>
								<th>Code</th>
								<th>Début</th>
								<th>Fin</th>
							</tr>
						</thead>
						<tbody>
							{foreach from=$promoActuelles item=codePromo}
							<tr id="code-{$codePromo.id_cart_rule}" class="{$codePromo.id_cart_rule}" onclick="findPromo('{$codePromo.id_cart_rule}')">
								<td><span id='cpromo'>{$codePromo.code}</span></td>
								<td><span id='date_from'>{$codePromo.date_from|date_format:"%Y-%m-%d"}</span></td>
								<td><span id='date_to'>{$codePromo.date_to|date_format:"%Y-%m-%d"}</span></td>
							</tr>
							{/foreach}
						</tbody>
					</table>
				</nav>
			</div>
		</div>

		<div class="panel col-md-9">
			<h3><i class="icon icon-tags"></i> {l s='Slider(s) créé(s)' mod='promo'}</h3>
			<p>
				<table id="promo" class="table table-striped">
					<thead>
						<tr>
							<th>ID</th>
							<th>Image</th>
							<th data-priority="1">Titre</th>
							<th>Description</th>
							<th>Légende</th>
							<th>Lien</th>
							<th>Date Début</th>
							<th>Date Fin</th>
							<th>Statut</th>
							<th data-priority="2">Actions</th>
						</tr>
					</thead>
					<tbody>

						{foreach from=$slides item=slide}
						<tr class="ligne-{$slide.id_promo_slides}">
							<td id="id_promo_slides">{$slide.id_promo_slides}</td>
							<td><img src="{$slide.image_url}" id="img" alt="" style="width: 250px;"></td>
							<td><span id='title'>{$slide.title}</span></td>
							<td><span id='description'>{$slide.description}</span></td>
							<td><span id='legend'>{$slide.legend}</span></td>
							<td><span id='url'>{$slide.url}</span></td>
							<td><span id='debut'>{$slide.debut}</span></td>
							<td><span id='fin'>{$slide.fin}</span></td>
							<td>
							{if $slide.debut <= $date AND $slide.fin >= $date}
							<i class="icon icon-check" style="color: green;"> </i>
							{else}
							<i class="icon icon-close" style="color: red;"></i>
							{/if}

							</span></td>
							<td><button type="button" onclick="editPromo('{$slide.id_promo_slides}')" class="btn btn-info" id="{$slide.id_promo_slides}" data-toggle="modal" data-target="#myModal"><i class="icon icon-pencil"></i></button> <a href="{$smarty.server.REQUEST_URI}&id={$slide.id_promo_slides}" class="confirmation"><button  class="btn btn-danger"><i class="icon icon-close"></i></button></a></td>
						</tr>
						{/foreach}

					</tbody>
				</table>
			</p>
		</div>
	</div>
	<!-- Début d'affichage des tables Code(s) Existant(s) et Slider(s) Créé(s) -->


	<!-- Début d'affichage du formulaire d'ajout de promotion -->
	<div class="panel">
		<h3><i class="icon icon-tags"></i>{l s='Ajouter un slider promotion' d='Modules.Promo.Admin'} </h3>

		<div>
			{if $msg == 2}
			<div class="alert alert-success">
				<strong>Super!</strong> La promotion est ajoutée
			</div>
			{elseif $msg == 1}
			<div class="alert alert-warning">
				<strong>Oups!</strong> La promotion n'a pas été ajoutée, veuillez vérifier le type d'image et la largeur autorisée
			</div>
			{else}

			{/if}
		</div>

		<form action="" method="post" id="formadd" onsubmit="return validateForm()" enctype="multipart/form-data">
			<div class="form-wrapper">
				<div class="form-group">

					<label for="exampleInputEmail1">
						Titre de la bannière
					</label>
					<input class="form-control"  type="text" id="title" name="title" value="{$title}" placeholder="{l s='Entrez un titre' d='Modules.Promo.Admin'}"/>
				</div>
				<div class="form-group">

					<label for="exampleInputPassword1">
						Description de la bannière
					</label>
					<textarea class="form-control" name="description" value="{$description}" placeholder="{l s='Entrez une description' d='Modules.Promo.Admin'}"></textarea>
				</div>
				<div class="form-group">

					<label for="exampleInputEmail1">
						Légende de la bannière
					</label>
					<input class="form-control" type="text" id="legend" name="legend" value="{$legend}" placeholder="{l s='Entrez une légende' d='Modules.Promo.Admin'}"/>
				</div>
				<div class="form-group">

					<label for="exampleInputEmail1">
						Lien de la bannière
					</label>
					<input class="form-control"  type="text" id="url" name="url" value="{$url}" placeholder="{l s='Entrez une image_url' d='Modules.Promo.Admin'}"/>
				</div>
				<div class="form-group">

					<label for="exampleInputEmail1">
						Début de la promotion
					</label>
					<input class="form-control datepicker" id="debutdate" type="text"  name="debut" value="{$debut}" placeholder="{l s='Date de début promo' d='Modules.Promo.Admin'}"/>
				</div>
				<div class="form-group">

					<label for="exampleInputEmail1">
						Fin de la promotion
					</label>
					<input class="form-control datepicker" id="findate" type="text" name="fin" value="{$fin}" placeholder="{l s='Date de fin promo' d='Modules.Promo.Admin'}"/>
				</div>
				<div class="form-group">

					<label for="exampleInputFile">
						Image
					</label>
					<input id="image" type="file" name="image" />
					<p class="help-block">
						Veuillez choisir une image de taille : 1110 pixels par 250 pixels (.png, .gif, .jpeg, jpg)
					</p>
				</div>

				<div class="panel-footer">
					<input type="submit" class="btn btn-success" value="Ajouter une promotion" name="addPromo" />
				</div>
			</form>


		</div>
		<!-- Fin d'affichage du formulaire d'ajout de promotion	-->

		<!-- Début du Modal Bootstrap qui permet la modification d'une promotion -->
		<div id="myModal" class="modal fade" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Editer la promotion</h4>
					</div>
					<div class="modal-body">
						<form action="" method="post" id="formupdate" onsubmit="return validateFormEdit()" enctype="multipart/form-data">
							<input type="text" id="eid" name="eid" value="{$eid}" style="display: none;" />
							<div class="form-wrapper">
								<div class="form-group">

									<label for="exampleInputEmail1">
										Titre de la bannière
									</label>
									<input class="form-control"  type="text" id="etitle" name="etitle" value="{$etitle}" placeholder="{l s='Entrez un titre' d='Modules.Promo.Admin'}"/>
								</div>
								<div class="form-group">

									<label for="exampleInputPassword1">
										Description de la bannière
									</label>
									<textarea class="form-control" id="edescription" name="edescription" value="{$edescription}" placeholder="{l s='Entrez une description' d='Modules.Promo.Admin'}"></textarea>
								</div>
								<div class="form-group">

									<label for="exampleInputEmail1">
										Légende de la bannière
									</label>
									<input class="form-control" type="text" id="elegend" name="elegend" value="{$elegend}" placeholder="{l s='Entrez une légende' d='Modules.Promo.Admin'}"/>
								</div>
								<div class="form-group">

									<label for="exampleInputEmail1">
										Lien de la bannière
									</label>
									<input class="form-control"  type="text" id="eurl" name="eurl" value="{$eurl}" placeholder="{l s='Entrez une image_url' d='Modules.Promo.Admin'}"/>
								</div>
								<div class="form-group">

									<label for="exampleInputEmail1">
										Début de la promotion
									</label>
									<input class="form-control datepicker" type="text" id="edebut" name="edebut" value="{$edebut}" placeholder="{l s='Date de début promo' d='Modules.Promo.Admin'}"/>
								</div>
								<div class="form-group">

									<label for="exampleInputEmail1">
										Fin de la promotion
									</label>
									<input class="form-control datepicker" type="text" id="efin" name="efin" value="{$efin}" placeholder="{l s='Date de fin promo' d='Modules.Promo.Admin'}"/>
								</div>
								<div class="form-group">

									<label for="exampleInputFile">
										Image
									</label>
									<input id="eimage" type="file" name="eimage" />
									<p class="help-block">
										Veuillez choisir une image de taille : 1110 pixels par 250 pixels (.png, .gif, .jpeg, jpg)
									</p>
									<p>
										<img src="" id="aimage" alt="" style="width: 250px;">
									</p>
								</div>


							</div>
							<div class="modal-footer">
								<input type="submit" class="btn btn-success" value="Editer une promotion" name="editPromo" />
								<button type="button" class="btn btn-default" data-dismiss="modal">Fermer</button>
							</form>
						</div>
					</div>

				</div>
			</div>
			<!-- Fin du Modal Bootstrap qui permet la modification d'une promotion -->


			<!-- Appel de JQuery pour les datatables -->
			{$jsdata}
			{$jsdata1}
			{$cssdata}
			<script type="text/javascript">

function validateForm() {
    var x = document.forms["formadd"]["title"].value;
    var y = document.forms["formadd"]["image"].value;
    var a = document.forms["formadd"]["debut"].value;
    var b = document.forms["formadd"]["fin"].value;
    if(a > b){
    	alert("Attention ! La date de fin ne peut pas être supérieure à la date de début");
    }
    if (x == "") {
        alert("Le titre doit être mentionné");
        return false;
    }else if (y == "") {
        alert("Une image doit être sélectionnée");
        return false;
    }else if (a == "") {
        alert("Une date de début doit être sélectionnée");
        return false;
    }else if (b == "") {
        alert("Une date de fin doit être sélectionnée");
        return false;
    }
}	

function validateFormEdit() {
    var x = document.forms["formupdate"]["etitle"].value;
    var a = document.forms["formupdate"]["edebut"].value;
    var b = document.forms["formupdate"]["efin"].value;
    if (x == "") {
        alert("Le titre doit être mentionné");
        return false;
    }else if (a == "") {
        alert("Une date de début doit être sélectionnée");
        return false;
    }else if (b == "") {
        alert("Une date de fin doit être sélectionnée");
        return false;
    }
}					
// Permet l'affichage des <table> de manière dynamique. Responsive, des colonnes sont prioritaires sur médias plus petits
$(document).ready(function(){
	$('#promo').DataTable({
		responsive: true,
		columnDefs: [
		{ responsivePriority: 1, targets: 0 },
		{ responsivePriority: 2, targets: -1 }
		]
	});
	$('#tablecode').DataTable({
		responsive: true
	});
});

// FUNCTION : Permet, par un clic sur la ligne du tableau Code Promo de retourner le titre, 
// la date de début et la date de fin dans les champs de saisie du formulaire d'ajout
function findPromo(code){
	$('#tablecode tr[id="code-'+ code +'"]').each(function(){
		var cpromo = $(this).find("#cpromo").html();
		var datefrom = $(this).find("#date_from").html();
		var dateto = $(this).find("#date_to").html();
		$('#formadd #title').val(cpromo);
		$('#formadd #debutdate').val(datefrom);
		$('#formadd #findate').val(dateto);
	});
}
// FUNCTION : Permet de retourner les valeurs d'une balise <tr> 
// par le bouton sélectionné et d'afficher celles-ci dans les champs de saisie				
function editPromo(promo){
	$(function() {
		$('button[id="'+ promo +'"]').each(function(){
			var id = $(this).parent().parent().find("#title");
			var id2 = $(this).parent().parent().find("#description");
			var id3 = $(this).parent().parent().find("#legend");
			var id4 = $(this).parent().parent().find("#url");
			var id5 = $(this).parent().parent().find("#debut");
			var id6 = $(this).parent().parent().find("#fin");
			var id7 = $(this).parent().parent().find("#img");
			$('#etitle').val(id.text());
			$('#edescription').val(id2.text());
			$('#elegend').val(id3.text());
			$('#eurl').val(id4.text());
			$('#edebut').val(id5.text());
			$('#efin').val(id6.text());
			$('#aimage').attr("src", id7.attr("src"));
			$('#eid').val(promo);
		});
	});
}

// Confirmation de suppression promotion
 $('.confirmation').on('click', function () {
        return confirm('Êtes-vous certain de vouloir supprimer cette promotion ?');
    });

</script>