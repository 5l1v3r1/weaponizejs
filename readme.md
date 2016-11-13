# Weaponize JS
## Making the most of XSS opportunities

This is the presentation I debuted at B-Sides Charleston 2016, along with
materials that I used in my examples. A lot of this was hacked together just
ahead of the presentation, so it probably may have some manual config steps that
I overlooked.

The material covered does *not* include how to find and exploit a XSS vulnerability,
but provides a few general javascript recipes for doing some useful things once
you have one in the context of a legitimately approved penetration test.
Obviously these may need to be tailored to the specifics of the vulnerability
you're exploiting, i.e. filter evasion specifics etc.

If you're someone with a web dev background or a strong grasp on javascript in
the context of a the browser already, you might mind these a bit rudimentary for
your needs.

This is generally in need of a lot of refinements. I'm not certain if or when I'm
going to take those on, but I will certainly try to help troubleshoot any show-stopping issues.

## Inventory
 - readme.md is the file you're reading.
 - weaponizejs.md is the presentation in original markdown form with speaker's notes
 - weaponizejs.pdf is the presentation in its original light theme without speaker's notes
 - weaponizejs_dark.pdf is the presentation in a dark theme with speakers notes - I think this shows better on a regular computer display.
 - /images contains images used in the presentation
 - /targethost is a vagrant box for setting up the targetapp on node.js
 - /evilhost is a vagrant box for hosting resources you might fetch during your exploit

 Both vagrant boxes use the same Ubuntu 14.04 base bento box.
 PDFs are generated with [Deckset](http://www.decksetapp.com/)

## Setting up the VMs

### Before you start
I did these a vagrant boxes on VirtualBox. They should work on VMWare Fusion or
Workstation as well but that is untested.
Vagrant itself and its documentation are available at: [https://www.vagrantup.com/](https://www.vagrantup.com/)
You will need to install it before proceeding.
I also use the [vagrant::hostupdater](https://github.com/cogitatio/vagrant-hostsupdater) plugin.
This isn't a requirement, but without it you will need to update your hosts file
manually or change the examples, as they reference the hosts by the names
*targetapp* and *evilhost* respectively.

### Setting up targetapp
 1. `cd targethost`
 2. `vagrant up` - there are a number of errors at the moment. I hope to smooth
 this out, but it doesn't seem to keep the VM from doing what it's supposed to.
 3. `vagrant ssh`
 4. `cd /targetapp`
 5. `npm install`
 6. `./start.sh` (you might need to enable execution permissions)

 The views are in the views directory (.hjs files) - these support mustache
 template syntax but it's not really used at the moment. The routes are under
 routes/ex.js.

### Setting up evilhost:8080
  1. `cd evilhost`
  2. `vagrant up`
  3. `vagrant ssh`
  4. `cd /var/www/html/content` - (the mountpoint for the shared folder is not
    really quite right, but it still works)
  5. `python cors_server.py` - this is taken from https://gist.github.com/enjalot/2904124

## About the examples
They're numbered 1-5. Most are accessible by http://targetapp/ex/{number}
 1. This was simple DOM traversal exercise, I just opened it and directly
 interacted via the browser's JS console. The page looks blank since they aren't renderable elements.
 2. The payload is embedded in the page and needs to be armed via execPayload() function. Use the browser's dev tools - specifically the JS console and network tab to see how this logs the username and password fields before submitting the form.
 3. This is a DOM rewrite, and there's an ex/3/login and ex/3/registration here. The login is for reference, and the registration is the actual target page. There's a global variable called template that already has the markup, so just getting the top div and replacing the innerHTML with template will do it.
 4. This is fetching js from evilhost by XHR and evaling it. It's setup in a fetchjs function.
 5. This is the same DOM rewrite as ex3, except that it fetches the markup using the XHR as in ex4. It's all setup in the fetch function.
