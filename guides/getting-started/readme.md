# Getting Started

This guide will help you get started using `XRB` templates in your Rails application.

## Installation

Add the gem to your project:

``` shell
$ bundle add xrb
```

## Usage

Simply create a new `.xrb` file in your `app/views` directory and start writing your template.

``` ruby
# app/views/hello/index.html.xrb
<ul>
<?r 10.times do |i| ?>
	<li>#{i}: Hello, world!</li>
<?r end ?>
</ul>
```
