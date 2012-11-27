/*
 * Спрятанные подробности
 */

(function($){
	$.fn.desc = function( userSettings ){
		var SETTINGS = {
			linkClass: 'link',
			linkWrapHTML: '<p class="b-desc-link"></p>',
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
				hideTitle = descContainer.attr('hide-title');
			
			init();
			assignEvents();
			
			function init(){
				descContainer.hide().removeAttr('title').removeAttr('hide-title');
				
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
		});
	};
})( jQuery );