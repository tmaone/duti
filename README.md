# About duti 
duti is a command-line utility capable of setting default applications for various document types on Mac OS X, using Apple's Uniform Type Identifiers. A UTI is a unique string describing the format of a file's content. For instance, a Microsoft Word document has a UTI of com.microsoft.word.doc. Using duti, the user can change which application acts as the default handler for a given UTI.


# Compiling
    make
    sudo make install

# Usage

duti can read settings from four different sources:

1) standard input

2) a settings file

3) a Mac OS X XML property list (plist)

4) command-line arguments.

A settings line, as read in cases 1 and 2, consists of an application's bundle ID, a UTI, and a string describing what role the application handles for the given UTI. The process is similar when duti processes a plist. If the path given to duti on the command-line is a directory, duti will apply settings from all valid settings files in that directory, excluding files whose names begin with '.'.

duti can also print out the default application information for a given extension (-x). This feature is based on public domain source code posted by Keith Alperin on the heliumfoot.com blog.

See the man page for additional usage details.

# Examples
Set Safari as the default handler for HTML documents:

	% duti -s com.apple.Safari public.html all

Set TextEdit as the default handler for Word documents:

	% duti com.apple.TextEdit	com.microsoft.word.doc	all

Set Finder as the default handler for ftp:// URLs:

	% duti -s com.apple.Finder ftp

Get default application information for .jpg files:

	% duti -x jpg
	Preview
	/Applications/Preview.app
	com.apple.Preview

# Support
duti is best-effort support. You can submit bug reports and feature requests for this version of the software at the duti GitHub project page:

    https://github.com/russellhancox/duti/

# License

duti is released into the public domain by Andrew Mortensen, 2008. It's provided as is without warranties of any kind. You can do anything you want with it. If you incorporate some or all of the code into another project, I'd appreciate credit for the work I've done, but that's all.

Andrew Mortensen
October 2008
