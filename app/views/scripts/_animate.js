/*  
  Animator.js 1.1.11
  
  This library is released under the BSD license:

  Copyright (c) 2006, Bernard Sumption. All rights reserved.
*/

function Animator(a){this.setOptions(a);var b=this;this.timerDelegate=function(){b.onTimerEvent()};this.subjects=[];this.state=this.target=0;this.lastTime=null} Animator.prototype={setOptions:function(a){this.options=Animator.applyDefaults({interval:20,duration:400,onComplete:function(){},onStep:function(){},transition:Animator.tx.easeInOut},a)},seekTo:function(a){this.seekFromTo(this.state,a)},seekFromTo:function(a,b){this.target=Math.max(0,Math.min(1,b));this.state=Math.max(0,Math.min(1,a));this.lastTime=(new Date).getTime();if(!this.intervalId)this.intervalId=window.setInterval(this.timerDelegate,this.options.interval)},jumpTo:function(a){this.target= this.state=Math.max(0,Math.min(1,a));this.propagate()},toggle:function(){this.seekTo(1-this.target)},addSubject:function(a){this.subjects[this.subjects.length]=a;return this},clearSubjects:function(){this.subjects=[]},propagate:function(){for(var a=this.options.transition(this.state),b=0;b<this.subjects.length;b++)if(this.subjects[b].setState)this.subjects[b].setState(a);else this.subjects[b](a)},onTimerEvent:function(){var a=(new Date).getTime(),b=a-this.lastTime;this.lastTime=a;a=b/this.options.duration* (this.state<this.target?1:-1);Math.abs(a)>=Math.abs(this.state-this.target)?this.state=this.target:this.state+=a;try{this.propagate()}finally{this.options.onStep.call(this),this.target==this.state&&this.stop()}},stop:function(){if(this.intervalId)window.clearInterval(this.intervalId),this.intervalId=null,this.options.onComplete.call(this)},play:function(){this.seekFromTo(0,1)},reverse:function(){this.seekFromTo(1,0)},inspect:function(){for(var a="#<Animator:\n",b=0;b<this.subjects.length;b++)a+=this.subjects[b].inspect(); a+=">";return a}};Animator.applyDefaults=function(a,b){var b=b||{},c,d={};for(c in a)d[c]=b[c]!==void 0?b[c]:a[c];return d};Animator.makeArrayOfElements=function(a){if(a==null)return[];if("string"==typeof a)return[document.getElementById(a)];if(!a.length)return[a];for(var b=[],c=0;c<a.length;c++)b[c]="string"==typeof a[c]?document.getElementById(a[c]):a[c];return b}; Animator.camelize=function(a){var b=a.split("-");if(b.length==1)return b[0];for(var a=a.indexOf("-")==0?b[0].charAt(0).toUpperCase()+b[0].substring(1):b[0],c=1,d=b.length;c<d;c++){var e=b[c];a+=e.charAt(0).toUpperCase()+e.substring(1)}return a};Animator.apply=function(a,b,c){if(b instanceof Array)return(new Animator(c)).addSubject(new CSSStyleSubject(a,b[0],b[1]));return(new Animator(c)).addSubject(new CSSStyleSubject(a,b))};Animator.makeEaseIn=function(a){return function(b){return Math.pow(b,a*2)}}; Animator.makeEaseOut=function(a){return function(b){return 1-Math.pow(1-b,a*2)}};Animator.makeElastic=function(a){return function(b){b=Animator.tx.easeInOut(b);return(1-Math.cos(b*Math.PI*a))*(1-b)+b}};Animator.makeADSR=function(a,b,c,d){d==null&&(d=0.5);return function(e){if(e<a)return e/a;if(e<b)return 1-(e-a)/(b-a)*(1-d);if(e<c)return d;return d*(1-(e-c)/(1-c))}};Animator.makeBounce=function(a){var b=Animator.makeElastic(a);return function(a){a=b(a);return a<=1?a:2-a}}; Animator.tx={easeInOut:function(a){return-Math.cos(a*Math.PI)/2+0.5},linear:function(a){return a},easeIn:Animator.makeEaseIn(1.5),easeOut:Animator.makeEaseOut(1.5),strongEaseIn:Animator.makeEaseIn(2.5),strongEaseOut:Animator.makeEaseOut(2.5),elastic:Animator.makeElastic(1),veryElastic:Animator.makeElastic(3),bouncy:Animator.makeBounce(1),veryBouncy:Animator.makeBounce(3)}; function NumericalStyleSubject(a,b,c,d,e){this.els=Animator.makeArrayOfElements(a);this.property=b=="opacity"&&window.ActiveXObject?"filter":Animator.camelize(b);this.from=parseFloat(c);this.to=parseFloat(d);this.units=e!=null?e:"px"} NumericalStyleSubject.prototype={setState:function(a){for(var a=this.getStyle(a),b=0,c=0;c<this.els.length;c++){try{this.els[c].style[this.property]=a}catch(d){if(this.property!="fontWeight")throw d;}if(b++>20)break}},getStyle:function(a){a=this.from+(this.to-this.from)*a;if(this.property=="filter")return"alpha(opacity="+Math.round(a*100)+")";if(this.property=="opacity")return a;return Math.round(a)+this.units},inspect:function(){return"\t"+this.property+"("+this.from+this.units+" to "+this.to+this.units+ ")\n"}};function ColorStyleSubject(a,b,c,d){this.els=Animator.makeArrayOfElements(a);this.property=Animator.camelize(b);this.to=this.expandColor(d);this.from=this.expandColor(c);this.origFrom=c;this.origTo=d} ColorStyleSubject.prototype={expandColor:function(a){var b,c;if(b=ColorStyleSubject.parseColor(a))return a=parseInt(b.slice(1,3),16),c=parseInt(b.slice(3,5),16),b=parseInt(b.slice(5,7),16),[a,c,b];window.ANIMATOR_DEBUG&&alert("Invalid colour: '"+a+"'")},getValueForState:function(a,b){return Math.round(this.from[a]+(this.to[a]-this.from[a])*b)},setState:function(a){for(var a="#"+ColorStyleSubject.toColorPart(this.getValueForState(0,a))+ColorStyleSubject.toColorPart(this.getValueForState(1,a))+ColorStyleSubject.toColorPart(this.getValueForState(2, a)),b=0;b<this.els.length;b++)this.els[b].style[this.property]=a},inspect:function(){return"\t"+this.property+"("+this.origFrom+" to "+this.origTo+")\n"}}; ColorStyleSubject.parseColor=function(a){var b="#",c;if(c=ColorStyleSubject.parseColor.rgbRe.exec(a)){for(var d=1;d<=3;d++)a=Math.max(0,Math.min(255,parseInt(c[d]))),b+=ColorStyleSubject.toColorPart(a);return b}if(c=ColorStyleSubject.parseColor.hexRe.exec(a)){if(c[1].length==3){for(d=0;d<3;d++)b+=c[1].charAt(d)+c[1].charAt(d);return b}return"#"+c[1]}return!1};ColorStyleSubject.toColorPart=function(a){a>255&&(a=255);var b=a.toString(16);if(a<16)return"0"+b;return b}; ColorStyleSubject.parseColor.rgbRe=/^rgb\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)$/i;ColorStyleSubject.parseColor.hexRe=/^\#([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$/;function DiscreteStyleSubject(a,b,c,d,e){this.els=Animator.makeArrayOfElements(a);this.property=Animator.camelize(b);this.from=c;this.to=d;this.threshold=e||0.5} DiscreteStyleSubject.prototype={setState:function(a){for(var b=0;b<this.els.length;b++)this.els[b].style[this.property]=a<=this.threshold?this.from:this.to},inspect:function(){return"\t"+this.property+"("+this.from+" to "+this.to+" @ "+this.threshold+")\n"}}; function CSSStyleSubject(a,b,c){a=Animator.makeArrayOfElements(a);this.subjects=[];if(a.length!=0){var d;if(c)b=this.parseStyle(b,a[0]),c=this.parseStyle(c,a[0]);else for(d in c=this.parseStyle(b,a[0]),b={},c)b[d]=CSSStyleSubject.getStyle(a[0],d);for(d in b)b[d]==c[d]&&(delete b[d],delete c[d]);var e,f,h,j;for(d in b){var i=String(b[d]),g=String(c[d]);if(c[d]==null)window.ANIMATOR_DEBUG&&alert("No to style provided for '"+d+'"');else{if(h=ColorStyleSubject.parseColor(i))j=ColorStyleSubject.parseColor(g), f=ColorStyleSubject;else if(i.match(CSSStyleSubject.numericalRe)&&g.match(CSSStyleSubject.numericalRe))h=parseFloat(i),j=parseFloat(g),f=NumericalStyleSubject,e=CSSStyleSubject.numericalRe.exec(i),g=CSSStyleSubject.numericalRe.exec(g),e=e[1]!=null?e[1]:g[1]!=null?g[1]:g;else if(i.match(CSSStyleSubject.discreteRe)&&g.match(CSSStyleSubject.discreteRe))h=i,j=g,f=DiscreteStyleSubject,e=0;else{window.ANIMATOR_DEBUG&&alert("Unrecognised format for value of "+d+": '"+b[d]+"'");continue}this.subjects[this.subjects.length]= new f(a,d,h,j,e)}}}} CSSStyleSubject.prototype={parseStyle:function(a,b){var c={};if(a.indexOf(":")!=-1)for(var d=a.split(";"),e=0;e<d.length;e++){var f=CSSStyleSubject.ruleRe.exec(d[e]);f&&(c[f[1]]=f[2])}else{var h;h=b.className;b.className=a;for(e=0;e<CSSStyleSubject.cssProperties.length;e++)d=CSSStyleSubject.cssProperties[e],f=CSSStyleSubject.getStyle(b,d),f!=null&&(c[d]=f);b.className=h}return c},setState:function(a){for(var b=0;b<this.subjects.length;b++)this.subjects[b].setState(a)},inspect:function(){for(var a="", b=0;b<this.subjects.length;b++)a+=this.subjects[b].inspect();return a}};CSSStyleSubject.getStyle=function(a,b){var c;if(document.defaultView&&document.defaultView.getComputedStyle&&(c=document.defaultView.getComputedStyle(a,"").getPropertyValue(b)))return c;b=Animator.camelize(b);a.currentStyle&&(c=a.currentStyle[b]);return c||a.style[b]};CSSStyleSubject.ruleRe=/^\s*([a-zA-Z\-]+)\s*:\s*(\S(.+\S)?)\s*$/;CSSStyleSubject.numericalRe=/^-?\d+(?:\.\d+)?(%|[a-zA-Z]{2})?$/;CSSStyleSubject.discreteRe=/^\w+$/; CSSStyleSubject.cssProperties=["azimuth","background","background-attachment","background-color","background-image","background-position","background-repeat","border-collapse","border-color","border-spacing","border-style","border-top","border-top-color","border-right-color","border-bottom-color","border-left-color","border-top-style","border-right-style","border-bottom-style","border-left-style","border-top-width","border-right-width","border-bottom-width","border-left-width","border-width","bottom", "clear","clip","color","content","cursor","direction","display","elevation","empty-cells","css-float","font","font-family","font-size","font-size-adjust","font-stretch","font-style","font-variant","font-weight","height","left","letter-spacing","line-height","list-style","list-style-image","list-style-position","list-style-type","margin","margin-top","margin-right","margin-bottom","margin-left","max-height","max-width","min-height","min-width","orphans","outline","outline-color","outline-style","outline-width", "overflow","padding","padding-top","padding-right","padding-bottom","padding-left","pause","position","right","size","table-layout","text-align","text-decoration","text-indent","text-shadow","text-transform","top","vertical-align","visibility","white-space","width","word-spacing","z-index","opacity","outline-offset","overflow-x","overflow-y"]; function AnimatorChain(a,b){this.animators=a;this.setOptions(b);for(var c=0;c<this.animators.length;c++)this.listenTo(this.animators[c]);this.forwards=!1;this.current=0} AnimatorChain.prototype={setOptions:function(a){this.options=Animator.applyDefaults({resetOnPlay:!0},a)},play:function(){this.forwards=!0;this.current=-1;if(this.options.resetOnPlay)for(var a=0;a<this.animators.length;a++)this.animators[a].jumpTo(0);this.advance()},reverse:function(){this.forwards=!1;this.current=this.animators.length;if(this.options.resetOnPlay)for(var a=0;a<this.animators.length;a++)this.animators[a].jumpTo(1);this.advance()},toggle:function(){this.forwards?this.seekTo(0):this.seekTo(1)}, listenTo:function(a){var b=a.options.onComplete,c=this;a.options.onComplete=function(){b&&b.call(a);c.advance()}},advance:function(){this.forwards?this.animators[this.current+1]!=null&&(this.current++,this.animators[this.current].play()):this.animators[this.current-1]!=null&&(this.current--,this.animators[this.current].reverse())},seekTo:function(a){a<=0?(this.forwards=!1,this.animators[this.current].seekTo(0)):(this.forwards=!0,this.animators[this.current].seekTo(1))}};