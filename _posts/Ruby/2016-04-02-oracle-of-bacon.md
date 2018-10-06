---
layout: post
title: "Oracle Of Bacon"
date: 2016-04-02 21:52:52 +0800
comments: true
categories: Ruby

---

[here](https://github.com/saasbook/hw-oracle-of-bacon)

```
bundle install
rspec spec
```

## xslt

Extensible Stylesheet Language Transformations.

```
sudo apt-get update
sudo apt-get install libxslt-dev libxml2-dev
```

## nokogiri

```
require 'nokogiri' # XML parser
@doc = Nokogiri::XML(File.read './spellcheck.xml')
match = @doc.xpath('//match')
match.methods()
match.first().text
data = match.map {|x| x.text}
```

## cgi

common gateway interface.

```
require 'cgi' # for escaping URIs
@uri = 'http://oracleofbacon.org/cgi-bin/xml?p='+CGI.escape(@api_key)
```

## uri

```
it { should match(URI::regexp) }
```

```
require 'open-uri' # allows open('http://...') to return body
xml = URI.parse(uri).read
```

---

Define the constructor for OracleOfBacon, which lies in `lib/`.

## initialize

```
class OracleOfBacon

    attr_accessor :from, :to
    attr_reader :api_key, :response, :uri

    def initialize(api_key='')
        @api_key = api_key
        @from = 'Kevin Bacon'
        @to = 'Kevin Bacon'
    end
end
```

## validate

```
class OracleOfBacon

    class InvalidError < RuntimeError ; end
    class InvalidKeyError < RuntimeError ; end
 
    include ActiveModel::Validations
    validates_presence_of :from
    validates_presence_of :to
    validates_presence_of :api_key
    validate :from_does_not_equal_to
    
    def from_does_not_equal_to
        errors.add(:base, 'From cannot be the same as To') if @from == @to
    end
end
```

## raise

```
begin  
  raise 'A test exception.'  
rescue Exception => e  
  puts e.message  
  puts e.backtrace.inspect  
end  
```
