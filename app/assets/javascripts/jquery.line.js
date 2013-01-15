/*
 * Canvas line
 */

(function($){
	$.fn.line = function( userSettings ){
		var SETTINGS = {
			targetSelector: '',
			sourceCorrectionX: 8,
			sourceCorrectionY: 13,
			sourceMarginX: 7,
			targetCorrectionX: 24,
			targetCorrectionY: 16,
			targetMarginX: 16,
			
			x1: 0,
			y1: 0,
			x2: 0,
			y2: 0,
			left: 0,
			top: 0,
			
			width: '1',
			color: '#CCC'
		};
		
		return this.each(function(){
			if( userSettings ){
				$.extend( SETTINGS, userSettings );
			}
			
			var canvas = $(this),
				canvasContext = canvas[0].getContext('2d'),
				canvasParent = canvas.parent(),
				target,
				lineRatio,
				
				x1 = SETTINGS.x1,
				y1 = SETTINGS.y1,
				x2 = SETTINGS.x2,
				y2 = SETTINGS.y2,
				left = SETTINGS.left,
				top = SETTINGS.top;
			
			if( canvasContext != null ){
				init();
			}
			else {
				return false;
			}
			
			function init(){
				if( SETTINGS.targetSelector != '' ){
					target = $(SETTINGS.targetSelector);
					
					if( target.length ){
						calculateLine();
					}
				}
				
				modifyCanvas();
				draw();
			}
			
			function calculateLine(){
				x2 = target.offset().left - canvasParent.offset().left - canvasParent.width() + SETTINGS.sourceCorrectionX + SETTINGS.targetCorrectionX;
				y2 = target.offset().top - canvasParent.offset().top - SETTINGS.sourceCorrectionY + SETTINGS.targetCorrectionY;
				
				lineRatio = y2/x2;
				
				left = canvasParent.width() + SETTINGS.sourceMarginX;
				top = SETTINGS.sourceCorrectionY + (SETTINGS.sourceMarginX + SETTINGS.sourceCorrectionX) * lineRatio;
				
				x2 -= SETTINGS.sourceMarginX + SETTINGS.sourceCorrectionX + SETTINGS.targetMarginX + SETTINGS.targetCorrectionX;
				y2 -= (SETTINGS.sourceMarginX + SETTINGS.sourceCorrectionX + SETTINGS.targetMarginX + SETTINGS.targetCorrectionX) * lineRatio;
				
				if( y2 < 0 ){
					y1 = Math.abs(y2);
					y2 = 0;
					
					top -= y1;
				}
			}
			
			function modifyCanvas(){
				canvas.css({
					left: left,
					top: top
				});
				
				canvas[0].width = Math.abs(x2 - x1);
				canvas[0].height = Math.abs(y2 - y1) + 5;
			}
			
			function draw(){
				canvasContext.beginPath();
				canvasContext.lineWidth = SETTINGS.width;
				canvasContext.strokeStyle = SETTINGS.color;
				canvasContext.moveTo(x1, y1);
				canvasContext.lineTo(x2, y2);
				canvasContext.stroke();
			}
		});
	};
})( jQuery );