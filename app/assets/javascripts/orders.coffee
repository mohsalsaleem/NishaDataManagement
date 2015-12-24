# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
	
	$ ->
	  # enable chosen js
	  $('.chosen-select').chosen
	    allow_single_deselect: true
	    no_results_text: 'No results matched'
	    width: '200px'


	$("#addField").click ->
		noOfFields = $("#noOfFields").val();
		if noOfFields == 0 or noOfFields == "" or noOfFields == "0"
			console.log("Saleem")
			alert("Enter the number of packages")
			return false
		hidden = $("div#frm").css("display")
		if hidden != "none"
			$("div#frm").empty()

		#form = '<form class="form-horizontal" id = "fields"></form>'	

		length = '<div class="col-xs-3" style="display:inline"><input type="number" id = "length" name = "length" class = "form-control"  placeholder="length"/></div>';

		width = '<div class="col-xs-3" style="display:inline"><input type="number" name = "width" id = "width" class = "form-control"  placeholder="width"/></div>';

		height = '<div class="col-xs-3" style="display:inline"><input type="number" name = "height" id = "height" class = "form-control"  placeholder="height"/></div>';

		weight = '<div class="col-xs-3" style="display:inline"><input type="number" name = "weight" id = "weight" class = "form-control"  placeholder="weight"/></div>';

		br = "<br />";

		for i in [1..noOfFields]
			$("div#frm").append('<h5>Package No: '+i+'</h5><br/><form class="form-horizontal" id = "fields'+i+'"></form><br/>');
			$('form#fields'+i+'').append(length,width,height,weight);
			$("form#fields"+i).append(br);

		#$("div#frm").css("display","block")	
		$("input#createPackagesBtn").css("display","block");

	$("#createPackagesBtn").click ->

		hidden = $("div#results").css("display")
		console.log(hidden)
		if hidden != "none"
			$("div#results").empty()
		lengths = $("input#length")
		widths = $("input#width")
		heights = $("input#height")
		weights = $("input#weight")

		numberOfPackages = lengths.length

		volumetricWeightedCost = 0.0
		totalVolumetricWeight = 0.0
		normalWeightedCost = 0.0
		totalWeight = 0.0
		actualCost = 0.0
		actualWeight = 0.0
		console.log(weights["0"].value)
		wLength = weights.length
		baggage_data = {}

		for k in [1..wLength]
			key = (k).toString()
			baggage_data[key] = {}
			if ( parseFloat(lengths[k-1].value) and parseFloat(widths[k-1].value) and parseFloat(heights[k-1].value) and parseFloat(weights[k-1].value) )
				baggage_data[key]["length"] = parseFloat(lengths[k-1].value)
				baggage_data[key]["width"] = parseFloat(widths[k-1].value)
				baggage_data[key]["height"] = parseFloat(heights[k-1].value)
				baggage_data[key]["weight"] = parseFloat(weights[k-1].value)
			else
				alert("Looks like you have missed out some stuff while entering dimensions in package no. "+key)
				return false	

		console.log(baggage_data)	

		for i in [0..wLength-1]
			index = (i).toString()
			totalWeight += parseFloat(weights[index].value)

		for j in [0..numberOfPackages-1]
			index = (j).toString()
			totalVolumetricWeight += (( parseFloat(lengths[index].value) * parseFloat(widths[index].value) * parseFloat(heights[index].value) ) / 5000)

		volumetricWeightedCost = totalVolumetricWeight*3.5
		normalWeightedCost = totalWeight*3.5

		actualCost = if volumetricWeightedCost > normalWeightedCost then volumetricWeightedCost else normalWeightedCost

		actualWeight = if totalVolumetricWeight > totalWeight then totalVolumetricWeight else totalWeight

		console.log("totalWeight "+totalWeight)
		console.log("normalWeightedCost "+normalWeightedCost)
		console.log("volumetricWeightedCost "+volumetricWeightedCost)	

		totalVolumetricWeightElement = '<h3>Total Volumetric Weight: '+totalVolumetricWeight+'</h3>'
		volumetricWeightedCostElement = '<h3>Total volumetric Weight cost: '+volumetricWeightedCost+'</h3>'
		noOfPackagesElement = '<h3>Number of Packages: '+numberOfPackages+'</h3>'
		totalWeightElement = '<h3>Total Weight: '+totalWeight+'</h3>'
		normalWeightCost = '<h3>Cost: '+normalWeightedCost+'</h3>'
		br = '<br />'

		$("div#results").append(br,noOfPackagesElement,br,totalWeightElement,br,normalWeightCost,br,totalVolumetricWeightElement,br,volumetricWeightedCostElement,br);
		$("div#results").css("display","block")

		$("input#order_total_pieces").val(numberOfPackages)
		$("input#order_items_cost").val(actualCost)
		$("input#order_total_weight").val(actualWeight)
		$("input#order_baggage_data").val(JSON.stringify(baggage_data))
		console.log(JSON.stringify(baggage_data))
		console.log($("input#order_baggage_data").val())

$(document).ready(ready)
$(document).on('page:load',ready)

@isNumberKey = (evt) ->
	charCode = if evt.which then evt.which else event.keyCode
	if charCode == 46
		return true
	else if charCode > 31 and (charCode < 48 || charCode > 57)
		return false
	else
		return true