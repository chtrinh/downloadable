# Downloadable

## SUMMARY
<<<<<<< HEAD:README.markdown
Allows for downloadable products that are served from you own server. 
Options include zipping multiple files for downloads, download limits, and emails links. 
Using the paperclip plugin, this should be already installed from spree installation. 

## QUICK START
1. script/extension install git://github.com/chtrinh/downloadable.git

## THANKS
Thank you to the all those in the Spree community! 
Suggestions and comments welcomed, chris.chtrinh@gmail.com

## NOTES
	- Requires 'rubyzip' gem - sudo gem install rubyzip
	- Enable X-Sendfile to be of praticial use, see comments in product_download_controller.
	- Ignores shipping/shipment attributes when there are ONLY downloadable products
	- Overrides core controllers/models like product.rb - might cause issues when upgrading to future releases.
	
## CHANGELOG
	- Bulk downloads! - auto zips all files you "enabled" in admin
	- Unlimited download settings
	- Download limits - Global and/or product specific settings
	- Admin CP changes are in the following Configuration tabs and Product tabs. 
	- Email links when order completes 

## TODO
	- SHA folder names to prevent unauthorize access to download links (prevent lucky guesses to public/xyz/xyz/)
	- Option to remove/flush unwanted zip files. 
	- Integrate spree-s3-download, probably create a fork
	- Integrate or fork to another extension for mulitiple email templates. 
	- Make it all RESTful. 
	
## REFERENCES
	- http://blog.lighttpd.net/articles/2006/07/02/x-sendfile
	- http://www.superwick.com/archives/2007/06/14/generating-zip-file-archives-via-ruby-on-rails/
=======
Allows for downloadable products that you serve from you own server. 
Using the paperclip plugin, this should be already installed from spree installation. 


## QUICK START

1. script/extension install git://github.com/chtrinh/downloadable.git

## NOTES
	- ignores shipping/shipment attributes in Order
	- CAUTION: overrides a lot of views
	- Changes to checkout.js in particular AJAX POST include in billing stage.  

## TODO
	- Authentication / Secret URLs, prevent unauthorize access to download links
	- Enable Sendfile-x send_file() instead of a regular link
	- Add decremental downloads (ie. MAX 3 downloads per user), currently unlimited
	- Create an Admin configuration page to support global downloadable options
	- Integrate spree-s3-download, probably create a fork
	- Integrate or fork to another extension for email templates, include URL link to customer in their invoiced email
	- Create Bulk downloads/upload feature
	- Enable zipping of multiple downloadable products
	- Stress test! 
	- Refactor/DRY up code to be a better fit for future spree releases.

## Warning 

Use at your own risk! If you add to this extension please consider creating a fork. Thank you!
>>>>>>> 5a91be7bf3d8b207465dc8688438fea192118b88:README.markdown

## License

The MIT License

<<<<<<< HEAD:README.markdown
Copyright (c) 2009 Chris Trinh
=======
Copyright (c) 2008 Chris Trinh
>>>>>>> 5a91be7bf3d8b207465dc8688438fea192118b88:README.markdown

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