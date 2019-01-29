{
	var result = []
    var obj = {};
    // {console.log(text())}
}

Contents = content:(Tag/Text/Comment)*{console.log(content);return content}
Text =  chars:[^<]+ {return {
		type: 'content',
        content: chars.join('')
	}}

Tag = openTag:OpenTag __ content:Contents __ closeTag:CloseTag{
    return {
      name:    openTag,
      content: content
    };
} / SelfCloseTag /StateMent

OpenTag = "<" tagName:TagName __ attrs:Attrs __ ">" {
	return {
    		name: tagName.join(''),
        	attrs: attrs
        }
}

CloseTag = "</" TagName ">"

// Contents = (!CloseTag .)*{console.log(text())}
// single = '//' p:([^\n]*) {return p.join('')}

SelfCloseTag = "<" TagName __ Attrs __ "/>"

Attrs = attrs:Attr*{return attrs}

Attr =  __ AttrName "=" OneQuotaOrTwo? __ AttrVal __ OneQuotaOrTwo? __ 
		/ AttrName{return text()}

TagName = [0-9a-zA-Z\-]+

AttrName = [0-9a-zA-Z\-]+

AttrVal = [0-9a-zA-Z\-\(\)\.\ \:\_\=\,\/\#\;\+\?\&\%\$\@\!\*]* {return text('')}

OneAttr = AttrName

OneQuotaOrTwo = '"'/"'"

Chinese = [\u0391-\uFFE5] {console.log(text())}

Comment =  "<!--" comment:(!"-->" .)* "-->" {
		comment = comment.map(v => v[1])
		return {
        	type:'commont',
            content: comment.join('')
        }
    }
StateMent = "<!DOCTYPE" (!">"  .)* ">"{return {
	type: 'statement',
    content: text()
}}

__ = [ \t\r\n]*
