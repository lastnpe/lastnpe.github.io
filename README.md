# lastnpe.github.io

This git repository contains the source code of the http://www.lastnpe.org web site.

Your contributions are more than welcome!


## Development

1. [Set up Jekyll](https://help.github.com/articles/setting-up-your-github-pages-site-locally-with-jekyll/)
2. Use `bundle exec jekyll serve --watch` to locally build and preview your Jekyll site
3. Use `bundle update` to update the Ruby github-pages and jekyll gems


## Troubleshooting

Use `rm -rf .bundle/ vendor/ ; git clean -fX` to solve this problem if it occurs locally:

```
Your Gemfile.lock is corrupt. The following gem is missing from the DEPENDENCIES section: 'mini_portile2'

```

and if it occurs on Tracis CI then add `install: bundle install` to `.travis.yml`
and git rm Gemfile.lock && echo "Gemfile.lock" >>.gitignore;
needed because its default is `bundle install --jobs=3 --retry=3 --deployment`,
the `--deployment` if a `Gemfile.lock` exists,
see https://docs.travis-ci.com/user/languages/ruby/#Travis-CI-uses-Bundler,
and that is causing some issues, see https://github.com/bundler/bundler/issues/4467.


Use `sudo dnf install ruby-devel` to solve this problem:

```
bundle install
Fetching gem metadata from https://rubygems.org/...........
(...)
Gem::Ext::BuildError: ERROR: Failed to build gem native extension.
    current directory: /home/vorburger/.gem/ruby/gems/RedCloth-4.2.9/ext/redcloth_scan
/usr/bin/ruby -r ./siteconf20161129-13214-o6qjjg.rb extconf.rb
mkmf.rb can't find header files for ruby at /usr/share/include/ruby.h
```


Use `sudo dnf install redhat-rpm-config` to solve this problem:

```
bundle install
/usr/share/ruby/mkmf.rb:456:in `try_do': The compiler failed to generate an executable file. (RuntimeError) You have to install development tools first.
```


Use `jekyll 3.3.0` instead of `jekyll _3.3.0_ ` (as shown on help.github.com) to solve this problem:

```
jekyll _3.3.0_ new .
/usr/share/rubygems/rubygems/dependency.rb:319:in `to_specs': Could not find 'jekyll' (= 3.3.0) - did find: [jekyll-2.4.0] (Gem::LoadError)
Checked in 'GEM_PATH=/home/vorburger/.gem/ruby:/usr/share/gems:/usr/local/share/gems', execute `gem env` for more information
	from /usr/share/rubygems/rubygems/dependency.rb:328:in `to_spec'
	from /usr/share/rubygems/rubygems/core_ext/kernel_gem.rb:65:in `gem'
	from /home/vorburger/bin/jekyll:22:in `<main>'

```


Add `gem 'therubyracer'` to the `Gemfile` and redo `bundle install`
(or one-time do `gem install therubyracer`, but in `Gemfile` is better to share with others),
to solve this problem with [Ruby Rails ExecJS](https://github.com/rails/execjs):

```
/home/vorburger/.gem/ruby/gems/execjs-2.7.0/lib/execjs/runtimes.rb:58:in `autodetect': Could not find a JavaScript runtime. See https://github.com/rails/execjs for a list of available runtimes. (ExecJS::RuntimeUnavailable)
	from /home/vorburger/.gem/ruby/gems/execjs-2.7.0/lib/execjs.rb:5:in `<module:ExecJS>'
	from /home/vorburger/.gem/ruby/gems/execjs-2.7.0/lib/execjs.rb:4:in `<top (required)>'
	from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:68:in `require'
	from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:68:in `require'
	from /home/vorburger/.gem/ruby/gems/coffee-script-2.4.1/lib/coffee_script.rb:1:in `<top (required)>'
	from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:68:in `require'
	from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:68:in `require'
	from /home/vorburger/.gem/ruby/gems/coffee-script-2.4.1/lib/coffee-script.rb:1:in `<top (required)>'
	from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:68:in `require'
	from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:68:in `require'
	from /home/vorburger/.gem/ruby/gems/jekyll-coffeescript-1.0.1/lib/jekyll-coffeescript.rb:2:in `<top (required)>'
	from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:68:in `require'
	from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:68:in `require'
	from /home/vorburger/.gem/ruby/gems/jekyll-2.4.0/lib/jekyll/deprecator.rb:46:in `block in gracefully_require'
	from /home/vorburger/.gem/ruby/gems/jekyll-2.4.0/lib/jekyll/deprecator.rb:44:in `each'
	from /home/vorburger/.gem/ruby/gems/jekyll-2.4.0/lib/jekyll/deprecator.rb:44:in `gracefully_require'
	from /home/vorburger/.gem/ruby/gems/jekyll-2.4.0/lib/jekyll.rb:141:in `<top (required)>'
	from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:68:in `require'
	from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:68:in `require'
	from /home/vorburger/.gem/ruby/gems/jekyll-2.4.0/bin/jekyll:6:in `<top (required)>'
	from /home/vorburger/bin/jekyll:23:in `load'
	from /home/vorburger/bin/jekyll:23:in `<main>'
```


Use `sudo dnf install gcc-c++` to solve this problem:

```
g++ -I. -I/home/vorburger/.gem/ruby/gems/libv8-3.16.14.17-x86_64-linux/vendor/v8/include -I/usr/include -I/usr/include/ruby/backward -I/usr/include -I.   -Wall -g
-rdynamic -fPIC -O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches
-specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -mtune=generic -m64 -o rr.o -c rr.cc
make: g++: Command not found
Makefile:207: recipe for target 'rr.o' failed
make: *** [rr.o] Error 127
```

