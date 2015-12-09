
Our game, Curvatron, was originally conceived as a mobile game with simple touch controls. Some changes had to be made to the way the game works and to how it is presented to make it feel better on PC. These changes would also make sense on consoles, even if we don't plan on ever releasing a console version.

## User Interface
Our initial idea with the user interface was to make everything as simple as possible, with large, round, touch-friendly buttons, using only icons for the buttons, no text at all. The only text on the menus was the title of the current menu. This way, if the icons were good enough, we wouldn’t need to worry about translating the app, everyone should be able to navigate the menus. Of course this wasn’t always easy to pull off, but it seemed to work well enough.

![Curvatron mobile](http://i.imgur.com/wd6QqtC.png)But this does not translate well for a PC game nowadays. On a PC, this kind of menu would only work with a mouse or with a touch screen, and many people prefer to use keyboard controls or an external controller. Even in such a simple game, this is something to take into account.

So we went with the classic vertical menu that you're used to seeing on most games. But we can't alienate the people who want to use only the mouse to play either, so it has to work well with both.

![Curvatron PC](http://i.imgur.com/j2HHpQu.png)The vertical menu may not use the screen space as efficiently, but the controls might become confusing if it were done differently.

## Settings
Us PC gamers like to be able to tinker with game settings and customize the game as we please. The simplicity of Curvatron doesn't really give you a lot of room for customization, but we still thought it would be a good idea to have a separate settings menu instead of the simple toggles we had on the main menu.

![Settings](http://i.imgur.com/CJqFxWn.png)Not a lot going on here right now. The only new setting is the one to toggle between windowed mode and fullscreen, but in the future we will likely add some other options.

There is also the addition of the exit button on the main menu, which is something that isn't present on most mobile games nowadays but is still necessary on PC.

## Screen Resolution
One problem we came across when making Curvatron was a very common one: supporting multiple resolutions and, maybe more importantly, different *aspect ratios*. Since we have a static camera with the entire game area visible at all times, we couldn't just crop the image, as that would actually affect the way the game worked. The easy way to do this would be to decide upon a base resolution, and just resize the image to fit the screen, with black bars covering the rest of the screen. This looks really ugly and could lead to the game beeing too small on smaller screens. So, instead of a base resolution, we chose a base *area*. We look at the current screen aspect ratio, and calculate the correct game dimensions to fit that base area. This way, the game has the same area across all devices, regardless of the aspect ratio. This should result on a difficulty level that's independent of resolution, up to a certain point. Here is how the game dimensions are calculated from the base area and screen resolution:

```
ratio = windowWidth/windowHeight;

gameHeight = Math.sqrt(baseArea/ratio);
gameWidth =  ratio*gameHeight;
```

For mobile, we kept this base area at 1024x1024 pixels, which looked good enough on most devices and worked well performance-wise. For the PC version we increased the area to 1440x1440, which means the game should look nice and sharp on resolutions up to 1080p. Unfortunately, Phaser and the way we made Curvatron doesn't really make it easy to change the actual display resolution to help with performance on slower systems.

That concludes the second part of this series. On the following parts I will start describing how we make an executable for our game.
