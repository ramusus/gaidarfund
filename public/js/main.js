$(function(){
	// Form hints
	$('.b-hint-label').hints();
	
	// Articles with more button
	var tiles = $('#tiles'),
		moreTilesLink = $('#more-tiles');
	
	if( tiles.length && moreTilesLink.length ){
		tiles.masonry({
			itemSelector: '.b-tiles-item'
		});
		
		moreTilesLink.click(function(event){
			$.ajax({
				url: $(this).attr('href')
			}).done(function(response){
				var newItems = $(response);
				newItems = newItems.filter('.b-tiles-item');
				
				newItems.css({opacity: 0}).appendTo(tiles);
				newItems.animate({opacity: 1});
				
				tiles.masonry('appended', newItems, true);
			});
			event.preventDefault();
		});
	}
});
	

String.prototype.supplant = function (o) {
    return this.replace(/{([^{}]*)}/g,
        function (a, b) {
            var r = o[b];
            return typeof r === 'string' || typeof r === 'number' ? r : a;
        }
    );
};