Since this is a web game, it runs inside a web browser. This obviously doesn't work for Steam games, so we need a wrapper to make it into an executable.

I went with [NW.js](http://nwjs.io/), but there are other alternatives, like [Electron](http://electron.atom.io/). I am going to continue refering mainly to NW.js throughout this series from now on, so if for one reason or another you are using a different approach, this information might not be as useful.

## NW.js
Right now, we're only developing for Windows, and I'm not sure if these steps are similar for other systems, but with NW.js we can make our web game an executable for Windows, Linux or Mac.
It's pretty easy to set things up. You can just [download it](http://nwjs.io/), extract all the contents to the directory where you have your index.html file, and run **nw.exe**. This is the fastest way to do it, and the best way to test the game while developing. We'll also need to create a **package.json** file in the same directory. This file contains a bunch of instructions for how NW.js should run. You can find more information about it [here](https://github.com/nwjs/nw.js/wiki/manifest-format). Here are some relevant settings for package.json:
```
{
    "main": "index.html",
    "name": "curvatron",
    "window": {
        "title": "Curvatron",
        "width": 800,
        "height": 600,
        "fullscreen": false,
        "toolbar": true
    },
    "version": "0.1.0",
    "chromium-args": "--data-path='./saves/' --in-process-gpu --disable-transparency"
}
```
The most important setting here is `"main"`. It points to the file that should be run when opening nw.exe. The `"toolbar"` setting should be kept on while testing, so we can access the console/debug stuff. Everything else is pretty self-explanatory, except for that last setting, `"chromium-args"`. We are passing three arguments to Chromium here.

The first one, `--data-path='./saves/'`, changes the directory used for local storage and temporary files. This helps users find their save files, and allows us to use Steam cloud to synchronize these files accross computers.

The other two arguments, `--in-process-gpu` and `--disable-transparency"`, are there to fix a problem where the Steam overlay (shows when you press Shift + Tab during a game) failed to appear.

## Packing the game files into the executable
We could distribute it just like this and it will work, but all our source code and assets are just there, which is a bit weird, right? One way around this is to pack everything into the exe, which can be achieved in a few different ways, the easiest of which is [Web2Executable](https://github.com/jyapayne/Web2Executable). There is a GUI version with a very easy to use interface. Just [download](https://github.com/jyapayne/Web2Executable/wiki/Downloads) it, extract it to wherever, and run it.

![Web2Executable](http://i.imgur.com/K3KXCpT.png)

Our package.json file will be edited according to the settings we choose in Web2Exe. Keep in mind that some of the new settings in your package.json are exclusive to Web2Exe, and may contain some absolute paths that won't transport well, so if you're using version control (like Git) you might run into some annoyances here.

The App and Window tabs have some relevant settings, so we change them to our taste. Under Export settings, we can configure the output directory and platforms. The Compression should be left to 0, as this increases load times.

Finally, we can press the export button. We can find our freshly baked executable(s) in the ouput directory somewhere. You'll notice the startup time is a bit slower this time around.

## Node modules
NW.js gives us a lot more freedom than we're used to having in the web browser. Using [Node's internal modules](http://nodejs.org/docs/latest/api/) it's a lot easier to do stuff like writing and reading local files ([File System module](https://nodejs.org/docs/latest/api/fs.html)), and much more, I presume!

We can also use third party modules to make a few tasks much easier. For instance, for Curvatron we used [node-twitter-api](https://www.npmjs.com/package/node-twitter-api), to allow the players to share scores and screenshots easily from within the game. But most importantly, we use [Greenworks](https://github.com/greenheartgames/greenworks) by Greenheart, for Steamworks integration with our game (achievements, workshop, etc.) We will discuss this module with more detail in the future. The only problem here is that Greenworks doesn't have Steam leaderboards support (yet).

## Renaming the .exe
Some modules might give you some trouble if you intend to rename your executable on Windows. Apparently, Greenworks is one of these modules. After renaming the .exe, you might find that your game doesn't run, with the error
`The specified module could not be found`.  
To fix this, we need to change the name that our module is bound to, using [rename-import-dll](https://github.com/ironSource/rename-import-dll/). [Download rid.zip](https://github.com/ironSource/rename-import-dll/releases) and extract it somewhere. You can find a good explanation on how to use the commands [here](http://developers.ironsrc.com/rename-import-dll/). The relevant command to fix Greenworks would be something like:
`rid.exe greenworks-win32.node nw.exe curvatron.exe`  
(given that rid.exe is in the same directory as the node file)

You should now have your executable set up and configured. Next we will be taking a closer look at what we can do with Greenworks.

[Part 4 - Steamworks](getting-a-phaser-game-on-steam-4)
