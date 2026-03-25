# Steam Multiboxing Made Easy
A simple setup to allow for running multiple Steam instances on the same PC, which can be used for testing Steam multiplayer features such as Steam Parties, Steam Network Messages, etc.

> ### Disclaimer
> This solution is currently working as of `2026-03-25`, but is (as far as I know) *NOT* a supported feature of Steam. This could break things, result in a VAC ban, *who knows?!* Use at your own risk, we're in uncharted waters beyond this point and neither I (Alice Bottino) nor Dreamware Media take any responsibility for what happens on the other side. Sailors be warned.


# Setup
### Step 1: Setup an alternate local windows user
In order for a second instance of steam to successfully run, it must be running in a seperate user enviroment, so we'll start by setting up an alternate local user in windows for this purpose.

1. Navigate to
    - Win 10: `Settings > Accounts > Family & other users`
    - Win 11: `Settings > Accounts > Other users`
2. Click the button labeled
    - Win 10: `Add someone else to this PC`
    - Win 11: `Add account`
3. When presented with the screen titled `How will this person sign in?` click on the link labeled `I don't have this person's sign-in information`
4. When presented with the screen titled `Create account` click on the link labeled `Add a user without a Microsoft account`
5. Create the new local user with a username that contains no spaces or special character
6. Complete the rest of the user creation flow

### Step 2: Setup the batch file
We'll be using a batch file to easily launch the second steam instance, which only requires a slight edit to the file.

1. Download `MultiboxSteam.bat` included in this repository, save it somewhere it's easy to find
2. Edit `MultiboxSteam.bat` in a text editor and simply replace `<alternate windows username>` with the username of our newly created alternate local account.

### Step 3: Enjoy!
And we're done! `MultiboxSteam.bat` can now be run to boot up a secondary steam instance alongside your usual instance of steam.

# Addendum
There are a couple things to note before I set you loose:

- Launching Steam without the command line argument `master_ipc_name_override` will search for any currently running instance of Steam. This means that if you run `MultiboxSteam.bat` before having a normal instance of Steam open, then attempting to open steam will mearly focus that open Steam instance.
   - The repository includes batch file called `RunSteamWithCurrentUser.bat`, which simply launches steam as the currently logged in user, with that username as its `master_ipc_name_override`. This should let you launch a "normal" instance of Steam if an alternate user's instance is already running.

- Inside of `MultiboxSteam.bat`, on the line `SET IPCNAME=%WINDOWSUSER%`, `%WINDOWSUSER%` can be replaced with any IPC name override desired. This can be useful if you're looking to manually override the enviroment variable `steam_master_ipc_name_override` before calling `SteamAPI_Init` at runtime, as described by [Freddie W's article](https://tsdo.in/blog/test-steam-networking/).
- In general I would recommend [Freddie W's article](https://tsdo.in/blog/test-steam-networking/) as a good overview of what's going on and what this all is useful for. Since Freddie released his article it seems that using multiple Windows accounts has become a requirement, which is what this repository attempts to explain and make easy to understand.
   - Freddie's article also has a good explanation of multiple ways to connect a given instance of a game to a given Steam instance via the IPC name. 

# Explanation
As a quick explantion of what all is going on here, it turns out that Steam doesn't *actually* enforce a single instance, instead instances of Steam can be manually identified by their "IPC Name". This is automatically set by Steam when it is launched, but it can be overrided by using the launch parameter `master_ipc_name_override`. 

However, if you (like I did) simply try to launch a second Steam with this parameter, things start to get... wierd. It turns out that Steam has a few different resources that it shares between instances (notably the Steam Client WebHelper, which will be the thing throwing errors). These shared resources seem to be shared within the current Windows user's enviroments, so we can work around this limitation by running out additional Steam Instance as a seperate user, in that users enviroment. 

As far as I am aware there is no limitation to the number of Steam instances you could run with this method, though each would need to be run by a seperate user account. I have not tested this so, good luck.
