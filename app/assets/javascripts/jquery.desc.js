/*
 * Спрятанные подробности
 */

(function($){
	$.fn.desc = function( userSettings ){
		var SETTINGS = {
			linkClass: 'link',
			linkWrapHTML: '<p class="b-desc-link"></p>',
			height: -1,
			animation: {
				type: 'slide',
				time: 200
			},
		};
		
		return this.each(function(){
			if( userSettings ){
				$.extend( SETTINGS, userSettings );
			}
			
			var descContainer = $(this),
				link,
				title = descContainer.attr('title'),
				hideTitle = descContainer.attr('hide-title'),
				originalHeight = descContainer.height(),
				collapsedHeight = SETTINGS.height;
			
			init();
			assignEvents();
			
			function init(){
				if( SETTINGS.height == -1 ){
					descContainer.hide();
				}
				else{
					descContainer.height(collapsedHeight);
				}
				descContainer.removeAttr('title').removeAttr('hide-title');
				
				link = $('<a class="' + SETTINGS.linkClass + '" href="?">' + title + '</a>');
				link.insertAfter(descContainer).wrap(SETTINGS.linkWrapHTML);
			}
			
			function assignEvents(){
				link.click(function(event){
					toggleDesc();
					
					event.preventDefault();
				});
			}
			
			function toggleDesc(){
				if( SETTINGS.height == -1 ){
					if( descContainer.css('display') == 'none' ){
						if( SETTINGS.animation.type == 'slide' ){
							descContainer.slideDown(SETTINGS.animation.time);
						}
						else{
							descContainer.show();
						}
						link.text(hideTitle);
					}
					else{
						if( SETTINGS.animation.type == 'slide' ){
							descContainer.slideUp(SETTINGS.animation.time);
						}
						else{
							descContainer.hide();
						}
						link.text(title);
					}
				}
				else{
					if( descContainer.height() == collapsedHeight ){
						if( SETTINGS.animation.type == 'slide' ){
							descContainer.animate({
								height: originalHeight
							}, SETTINGS.animation.time);
						}
						else{
							descContainer.height(originalHeight);
						}
						link.text(hideTitle);
					}
					else{
						if( SETTINGS.animation.type == 'slide' ){
							descContainer.animate({
								height: collapsedHeight
							}, SETTINGS.animation.time);
						}
						else{
							descContainer.height(collapsedHeight);
						}
						link.text(title);
					}
					
				}
			}
		});
	};
})( jQuery );