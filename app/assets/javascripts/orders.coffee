# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = -> 
	$("#addField").click ->
		noOfFields = $("#noOfFields").val();
		if noOfFields == 0 or noOfFields == "" or noOfFields == "0"
			console.log("Saleem")
			alert("Enter the number of packages")
			return false
		hidden = $("div#fields").css("display")
		if hidden != "none"
			$("div#fields").empty()

		length = '<input type="text" id = "length" name = "length" class = "form-control" placeholder="length"/>';

		width = '<input type="text" name = "width" id = "width" class = "form-control" placeholder="width"/>';

		height = '<input type="text" name = "height" id = "height" class = "form-control" placeholder="height"/>';

		weight = '<input type="text" name = "weight" id = "weight" class = "form-control" placeholder="weight"/>';

		br = "<br />";

		for i in [1..noOfFields]
			$("div#fields").append("<p>"+i+"</p>",length,br,width,br,height,br,weight,br);
		$("div#fields").css("display","block")	
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

		volumetricWeightedCost = 0
		totalVolumetricWeight = 0
		normalWeightedCost = 0
		totalWeight = 0
		actualCost = 0
		actualWeight = 0
		console.log(weights["0"].value)
		wLength = weights.length
		baggage_data = {}

		for k in [1..wLength]
			key = (k).toString()
			baggage_data[key] = {}
			if ( parseInt(lengths[k-1].value) and parseInt(widths[k-1].value) and parseInt(heights[k-1].value) and parseInt(weights[k-1].value) )
				baggage_data[key]["length"] = parseInt(lengths[k-1].value)
				baggage_data[key]["width"] = parseInt(widths[k-1].value)
				baggage_data[key]["height"] = parseInt(heights[k-1].value)
				baggage_data[key]["weight"] = parseInt(weights[k-1].value)
			else
				alert("Looks like you have missed out some stuff while entering dimensions in package no. "+key)
				return false	

		console.log(baggage_data)	

		for i in [0..wLength-1]
			index = (i).toString()
			totalWeight += parseInt(weights[index].value)

		for j in [0..numberOfPackages-1]
			index = (j).toString()
			totalVolumetricWeight += (( parseInt(lengths[index].value) * parseInt(widths[index].value) * parseInt(heights[index].value) ) / 5000)

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