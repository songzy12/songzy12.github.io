---
layout: post
title: "JavaScript"
date: 2017-04-02 23:04:43 +0800
comments: true
categories: 

---

## Javascript Level 1

```
<script type='text/javascript'> 
$(function(){ 
	$('.level-form').submit(function(e){ 
		e.preventDefault(); 
		if(document.getElementById('pass').value == correct) { 
			document.location = '?pass=' + correct; 
		} else { 
			alert('Incorrect password') 
		} 
	})
})
</script>
```

```
 <script type='text/javascript'> var correct = 'jrules' </script>
```

## Javascript Level 2

```
<script type='text/javascript'> 
$(function(){ 
	$('.level-form').submit(function(e){ 
		e.preventDefault(); 
		if ($('.level-form #pass')[0].value.length == length) { 
			document.location = "2?x=" + length; 
		} else { 
			alert('Incorrect Password'); 
		} 
	}); 
}); 
</script>
```

```
<script type='text/javascript'>
    var length = 5;
    var x = 3;
    var y = 2;
    y = Math.sin(118.13);
    y = -y;
    x = Math.ceil(y);
    y++;
    y = y+x+x;
    y *= (y/2);
    y++;
    y++;
    length = Math.floor(y);
</script>
```

## Javascript Level 3

```
<script type='text/javascript'> 
var thecode = 'code123'; 
$(function(){ 
	$('.level-form').submit(function(e){ 
		e.preventDefault(); 
		if ($('.level-form #pass')[0].value == thecode) { 
			document.location = "?pass=" + thecode; 
		} else { 
			alert('Incorrect Password'); 
		} 
	}); 
}); 
</script>
```

```
getinthere
```

```
<script type='text/javascript' src='https://hackthis-10af.kxcdn.com/files/js/min/main.js?1446747682'></script>
```

```
var thecode='getinthere';
```

## Javascript Level 4

```
view-source:https://www.hackthis.co.uk/levels/javascript/4
```

```
<div class='level-form'>
    <script> document.location = '?input'; </script>
    <div class='center'>The password is: smellthecheese</div>

</div>
```

## Javascript Level 5

```
view-source:https://www.hackthis.co.uk/levels/javascript/5
```

```
<script type='text/javascript' src='https://hackthis-10af.kxcdn.com/files/js/min/extra_48d468a93b.js?1429997775'></script>
```

```
a=window.location.host+"";b=a.length;c=4+((5*10)*2);d=String.fromCharCode(c,-(41-Math.floor(1806/13)),Math.sqrt(b-2)*29,(b*8)-29);p=prompt("Password:","");if(p==d){window.location="?pass="+p;}else{window.location="/levels/";}
```