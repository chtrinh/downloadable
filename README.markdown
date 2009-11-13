# Downloadable

## SUMMARY
A Spree extension: allows for downloadable products that are served from your own server. 
Options include zipping multiple files for downloads, download limits, and emails links. 
Using the paperclip plugin, this should be already installed from Spree installation. 
Support for current Spree gem: Spree 0.9.2.

## WARNING
Does not smoothly updates from older versions of this extension.

## QUICK START
1. script/extension install git://github.com/chtrinh/downloadable.git
2. rake gems:install
3. rake db:migrate (or rake db:bootstrap)

## CHANGELOG
  - Added variant support - Modeled after the Spree's image paperclip attachment.
  - Auto zips files when variant/product has more than one file.
  - Code refactoring - minimized overriding of Spree model/controller/view for easier integration when upgrading to future releases.

## NOTES
	- Requires 'rubyzip' gem (sudo gem install rubyzip)
	- Enable X-Sendfile to be of praticial use, see comments in downloadable_controller.
	- Ignores shipping/shipment attributes when there are ONLY downloadable products.
	- Disables guest checking when order has a downloadable content.

## TODO
	- SHA folder names to prevent unauthorize access to download links (prevent lucky guesses to public/xyz/xyz/)
	- Integrate spree-s3-download, probably create a fork
	- Integrate or fork to another extension for mulitiple email templates. 

## THANKS
Thank you to the all those in the Spree community! 
Suggestions and comments welcomed, chris.chtrinh@gmail.com
	  mishawagon - Possible conflicts with 'application_controller.rb'
	  pkordel/mishawagon- For nil.downloadable? bug. 
	  dreamcat4 - Found bugs in order models.
	  welemski - Variant support suggestion.
	
## REFERENCES
	- http://blog.lighttpd.net/articles/2006/07/02/x-sendfile
	- http://www.superwick.com/archives/2007/06/14/generating-zip-file-archives-via-ruby-on-rails/

## License

The MIT License

Copyright (c) 2009 Chris Trinh

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.