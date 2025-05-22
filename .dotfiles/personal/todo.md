jjimenez.6814@gmail.com



https://www.decisionproblem.com/paperclips/index2.html

https://www.youtube.com/shorts/-Myppv5cZUM

// FRANK approve tx to set allowance
cast send 0xc351628EB244ec633d5f21fBD6621e1a683B1181 "approve(address,uint256)()" 0xA51c1fc2f0D1a1b8494Ed1FE312d7C3a78Ed91C0 1000000000000000000000000000 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --rpc-url $RPC_URL

// DRAC approve tx to set allowance
cast send 0xDC11f7E700A4c898AE5CAddB1082cFfa76512aDD "approve(address,uint256)()" 0xA51c1fc2f0D1a1b8494Ed1FE312d7C3a78Ed91C0 1000000000000000000000000000 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --rpc-url $RPC_URL

// FRANK/WETH pool, 0% lpFee, 1wei WIn
cast send 0xA51c1fc2f0D1a1b8494Ed1FE312d7C3a78Ed91C0 "createPool(address,address,uint16,(uint256,uint256,uint256,uint256),uint256,uint256,string,string)()" 0xc351628EB244ec633d5f21fBD6621e1a683B1181 0x5FbDB2315678afecb367f032d93F642f64180aa3 0 \(1000000000000000000,100000000000000,1000000000000000000,1000000000000000000000000\) 1000000000000000000000 1 POSToken FRANK\/WETH --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --rpc-url $RPC_URL

// FRANK/STC pool, 10% lpFee, 500 FRANK WIn
cast send 0xA51c1fc2f0D1a1b8494Ed1FE312d7C3a78Ed91C0 "createPool(address,address,uint16,(uint256,uint256,uint256,uint256),uint256,uint256,string,string)()" 0xc351628EB244ec633d5f21fBD6621e1a683B1181 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0 1000 \(1000000000000000000,100000000000000,1000000000000000000,1000000000000000000000000\) 1000000000000000000000 500000000000000000000 POSToken FRANK\/STC --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --rpc-url $RPC_URL

// DRAC/WETH pool, 0% lpFee 1
cast send 0xA51c1fc2f0D1a1b8494Ed1FE312d7C3a78Ed91C0 "createPool(address,address,uint16,(uint256,uint256,uint256,uint256),uint256,uint256,string,string)()" 0xDC11f7E700A4c898AE5CAddB1082cFfa76512aDD 0x5FbDB2315678afecb367f032d93F642f64180aa3 0 \(1000000000000000000,100000000000000,1000000000000000000,1000000000000000000000000\) 1000000000000000000000 1 POSToken DRAC\/WETH --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --rpc-url $RPC_URL

// DRAC/STC pool, 10% lpFee
cast send 0xA51c1fc2f0D1a1b8494Ed1FE312d7C3a78Ed91C0 "createPool(address,address,uint16,(uint256,uint256,uint256,uint256),uint256,uint256,string,string)()" 0xDC11f7E700A4c898AE5CAddB1082cFfa76512aDD 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0 1000 \(1000000000000000000,100000000000000,1000000000000000000,1000000000000000000000000\) 1000000000000000000000 500000000000000000000 POSToken DRAC\/STC --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --rpc-url $RPC_URL

cast send 0xA51c1fc2f0D1a1b8494Ed1FE312d7C3a78Ed91C0 "createPool(address,address,uint16,(uint256,uint256,uint256,uint256),uint256,uint256,string,string)()" 0x1c85638e118b37167e9298c2268758e058DdfDA0 0x5FbDB2315678afecb367f032d93F642f64180aa3 250 \(881425842017,34910778341167333000,111111111111111110000000,3824218750000000000000000\) 1000000000000000000000000 500000000000000000000000 POSToken FRANK\/WETH --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
cast send 0xA51c1fc2f0D1a1b8494Ed1FE312d7C3a78Ed91C0 "createPool(address,address,uint16,(uint256,uint256,uint256,uint256),uint256,uint256,string,string)()" 0x1c85638e118b37167e9298c2268758e058DdfDA0 0x5FbDB2315678afecb367f032d93F642f64180aa3 250 \(881425842017,34910778341167333000,111111111111111110000000,382421\) 1000000000000000000000000 500000000000000000000000 POSToken FRANK\/WETH --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --rpc-url $RPC_URL

const priceIds = db['price-histories'].find({}, { \_id: 1 }).sort({ timestamp: 1 }).toArray().map(d => d.\_id);
const targetField = 'priceHistory';
db.pools.updateOne( { \_id: ObjectId('67ff7b349bbb69603dd3662d') }, { $set: { [targetField]: priceIds } });

-- Plugins to look at and maybe install
folke/flash.nvim
folke/trouble.nvim?
folke/todo-comments.nvim?

mason-tool-installer?
null-ls.nvim or conform.nvim + Mason to manage formatters (works with lsp-zero).
lewis6991/gitsigns.nvim?
numToStr/Comment.nvim for gcc/gc comments?
windwp/nvim-autopairs?
kylechui/nvim-surround?
lukas-reckmann/indent-blankline.nvim (now “ibl.nvim”)?
mfussenegger/nvim-dap + nvim-dap-ui + mason-nvim-dap for quick debugger setup?
lazy-load colourschemes so they don’t all load at startup: lazy = true, priority = 1000, config = function() vim.cmd.colorscheme('tokyonight') end

fix: vim.validate is deprecated. Feature will be removed in Nvim 1.0?

-̶ ̶l̶o̶c̶k̶ ̶t̶h̶e̶ ̶x̶ ̶o̶r̶ ̶y̶ ̶t̶o̶k̶e̶n̶ ̶a̶d̶d̶ ̶a̶m̶o̶u̶n̶t̶ ̶t̶o̶ ̶0̶ ̶i̶n̶ ̶x̶M̶i̶n̶ ̶a̶n̶d̶ ̶x̶M̶a̶x̶ ̶e̶d̶g̶e̶ ̶c̶a̶s̶e̶s̶
-̶ ̶l̶p̶ ̶t̶o̶k̶e̶n̶ ̶t̶r̶a̶n̶s̶f̶e̶r̶ ̶h̶a̶n̶d̶l̶e̶r̶ ̶t̶o̶ ̶u̶p̶d̶a̶t̶e̶ ̶o̶w̶n̶e̶r̶s̶h̶i̶p̶ ̶a̶n̶d̶ ̶h̶a̶n̶d̶l̶e̶ ̶b̶u̶r̶n̶s̶
-̶ ̶m̶a̶k̶e̶ ̶a̶ ̶n̶e̶w̶ ̶c̶h̶a̶i̶n̶ ̶s̶n̶a̶p̶s̶h̶o̶t̶
̶ ̶ ̶ ̶-̶ ̶b̶u̶m̶p̶ ̶t̶h̶e̶ ̶a̶m̶o̶u̶n̶t̶ ̶o̶f̶ ̶W̶E̶T̶H̶ ̶a̶n̶d̶ ̶W̶O̶L̶F̶Y̶ ̶t̶h̶a̶t̶ ̶g̶e̶t̶ ̶m̶i̶n̶t̶e̶d̶ ̶t̶o̶ ̶b̶e̶ ̶a̶ ̶l̶o̶t̶ ̶b̶i̶g̶g̶e̶r̶
-̶ ̶ ̶ ̶f̶i̶g̶u̶r̶e̶ ̶o̶u̶t̶ ̶i̶n̶i̶t̶i̶a̶l̶ ̶p̶r̶i̶c̶e̶ ̶i̶s̶s̶u̶e̶ ̶w̶i̶t̶h̶ ̶c̶r̶e̶a̶t̶e̶P̶o̶o̶l̶ ̶f̶r̶o̶m̶ ̶a̶d̶m̶i̶n̶U̶I̶
-   calculate APR for positions
-̶ ̶ ̶ ̶r̶e̶m̶o̶v̶e̶ ̶c̶d̶n̶.̶b̶u̶i̶l̶d̶e̶r̶.̶i̶o̶ ̶l̶i̶n̶k̶s̶
-̶ ̶ ̶ ̶p̶o̶o̶l̶ ̶n̶a̶m̶e̶ ̶i̶s̶ ̶d̶i̶s̶p̶l̶a̶y̶i̶n̶g̶ ̶i̶n̶ ̶w̶r̶o̶n̶g̶ ̶o̶r̶d̶e̶r̶ ̶i̶n̶ ̶a̶ ̶b̶u̶n̶c̶h̶ ̶o̶f̶ ̶p̶l̶a̶c̶e̶s̶ ̶
-   look at liquidity withdrawal issue Steve found (withdraw 100% and see if there are issues)
-   date filters as Tabs in admin-ui pool details page
-   We might want some kind of websocket connection between indexer and swap-ui so that swap-ui can re-fetch data and update itself even if transactions are made to a pool outside of the UI via CLI or something
    -   I suppose we could possibly refetch using the price feed websocket updates as a trigger? So, basically more of a polling approach from swap-ui that simply re-fetches from the API every so often.
-̶ ̶ ̶ ̶F̶i̶g̶u̶r̶e̶ ̶o̶u̶t̶ ̶p̶r̶o̶p̶e̶r̶ ̶U̶S̶D̶ ̶P̶r̶i̶c̶e̶ ̶C̶o̶n̶v̶e̶r̶s̶i̶o̶n̶ ̶s̶o̶l̶u̶t̶i̶o̶n̶
-̶ ̶ ̶ ̶t̶r̶a̶n̶s̶a̶c̶t̶i̶o̶n̶ ̶t̶a̶b̶l̶e̶ ̶t̶w̶e̶a̶k̶s̶ ̶o̶n̶ ̶p̶o̶o̶l̶ ̶d̶e̶t̶a̶i̶l̶s̶ ̶p̶a̶g̶e̶
 ̶ ̶ ̶ ̶-̶ ̶ ̶ ̶s̶o̶r̶t̶a̶b̶l̶e̶ ̶c̶o̶l̶u̶m̶n̶s̶
 ̶ ̶ ̶ ̶-̶ ̶ ̶ ̶s̶t̶y̶l̶i̶n̶g̶ ̶t̶w̶e̶a̶k̶s̶
 ̶ ̶ ̶ ̶-̶ ̶ ̶ ̶"̶U̶S̶D̶"̶ ̶c̶o̶l̶u̶m̶n̶ ̶i̶s̶ ̶s̶t̶i̶l̶l̶ ̶"̶T̶O̶D̶O̶"̶

# Stuff to do

-   Check into Big Stick tickets
    -   Maybe hit up Bear?
-   buy off-site flights
-   Call a lawyer to talk about legal options
-   Call the damn doctor
-   Clear out emails!
    -   Look at framily reunion stuff
    -   send off-site dates to Sarah and Cara


Edgerunners
Solo levelling (1st)

https://www.youtube.com/watch?v=RgNisLVVykA -- Laika cover... learn it!!

Woodworking kit: - kali linux USB boot stick - tails linux USB boot stick - BadUSB -- keylogger, remote backdoor, etc. - flipper zero - pwnagatchi - antenna for wifi hacking - lock pick set - laptop -- running arch, btw - burner SIM card with data?

DeepSeek hardware resources / software walkthrough stuff: - https://x.com/carrigmat/status/1884244369907278106 - https://v-color.net/products/ddr5-ecc-rdimm-servermemory?variant=44758743416999 - https://www.reddit.com/r/ollama/comments/1icv7wv/hardware_requirements_for_running_the_full_size/ - https://news.ycombinator.com/item?id=42897205#:~:text=This%20runs%20the%20671B%20model,motherboard%20using%20768GB%20of%20RAM. - https://www.youtube.com/watch?v=Wjrdr0NU4Sk - https://www.youtube.com/watch?v=XvbVePuP7NY - https://www.youtube.com/watch?v=sxTNACldK3Y - https://www.youtube.com/watch?v=GBR6pHZ68Ho - https://www.reddit.com/r/selfhosted/comments/1iekz8o/beginner_guide_run_deepseekr1_671b_on_your_own/

# Indexer issues:

    - admin-ui is (sometimes? always?) not updating new values after transactions happen... weird.

-   Outstanding Liquidity Feature work

    -   "todo" values left over on admin-ui pool list view / overview page liquidity card
    -   Also the "outstanding supply" value on liquidity details page is hardcoded to "2M"
    -   LiquidityDetails page Fees card has a bunch of design updates

-   Try entering a random unregistered erc20 as the "game" token and see what breaks
    -   Turns out there are a handful of issues with using unregistered tokens as the xToken in a pool
        1. Since the token is unregistered, we have no way to find a game to associate the pool with
        2. Since "liquidity" admin pages were initially organized _within_ a game in the design specs,
           this causes an issue because it makes it impossible to link the new pool that was created
           to any particular game. The Admin-UI is currently retrieving pools from the API as part of
           the "game" json blob, again because of the way the initial design specs had organized everything.
           So because the pool can't be connected to a game, it's not in the game's json blob, so it's
           invisible to the admin UI.
        3. Fixing all this will just be a matter of refactoring the way pools are stored and retrieved...
            - They'll no longer have any linkage with a "game" object in the DB
            - They'll need their own API endpoint to be retrieved by the front-end(s)
            - We'll need to decide how they are retrieved... I assume it will simply be done using the
              deployment owner's wallet address, so that an admin using the admin-ui, when navigating
              to the Liquidity pages, will see a list of the pools they have specifically created themselves.
            - This last point has some consequences for the UI... specifically, there is no "organization level"
              way of grouping pools... Let's say a single client decides to have multiple approved pool
              deployment owners who each create some pools... When they visit the UI, they would only be
              able to see the pools that they themselves created, rather than all the pools which have
              been created by their organization. This isn't necessarily good or bad, I guess, it's just a
              fact of the way things currently work. If we want there to be a way to group an organization's
              pools somehow, we'll need to come up with a new solution of some kind for that.

Movies to watch: - Where the wild things are - Edward Scissorhands - Elvis - Ex Machina - Titane - Aeon Flux - Basic Instinct - Flesh and Blood - Hollow Man - Showgirls - A Million Ways to Die in the West

common saints - idol eyes

Thunder claps rumble
Through the white wine bottle

Velvet thighs
Soft, rough, soft, rough

A furtive gaze
An eloquent maze
Is there a bear in there?

Two humans live
Sweet mountain nights
