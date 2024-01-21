FPS = 30 -- #  frames per second, the general speed of the program
WINDOWWIDTH = 640 -- #  size of window's width in pixels
WINDOWHEIGHT = 480 -- #  size of windows' height in pixels
REVEALSPEED = 8 -- #  speed boxes' sliding reveals and covers
BOXSIZE = 40 -- #  size of box height & width in pixels
GAPSIZE = 10 -- #  size of gap between boxes in pixels
BOARDWIDTH = 6 -- #  number of columns of icons
BOARDHEIGHT = 4 -- #  number of rows of icons


XMARGIN = math.floor((WINDOWWIDTH - (BOARDWIDTH * (BOXSIZE + GAPSIZE))) / 2)
YMARGIN = math.floor((WINDOWHEIGHT - (BOARDHEIGHT * (BOXSIZE + GAPSIZE))) / 2)


GRAY     = {100, 100, 100}
NAVYBLUE = { 60,  60, 100}
WHITE    = {255, 255, 255}
RED      = {255,   0,   0}
GREEN    = {  0, 255,   0}
BLUE     = {  0,   0, 255}
YELLOW   = {255, 255,   0}
ORANGE   = {255, 128,   0}
PURPLE   = {255,   0, 255}
CYAN     = {  0, 255, 255}


BGCOLOR = NAVYBLUE
LIGHTBGCOLOR = GRAY
BOXCOLOR = WHITE
HIGHLIGHTCOLOR = BLUE


DONUT = 'donut'
SQUARE = 'square'
DIAMOND = 'diamond'
LINES = 'lines'
OVAL = 'oval'

ALLCOLORS = {RED, GREEN, BLUE, YELLOW, ORANGE, PURPLE, CYAN}
NUMALLCOLORS = 7

ALLSHAPES = {DONUT, SQUARE, DIAMOND, LINES, OVAL}
NUMALLSHAPES = 5

function love.load()
    print("loading...")
    love.graphics.setBackgroundColor(BGCOLOR)

    -- loop 
    -- for i=0, 10, 2 do 
    --     print(i)
    -- end
    -- final

    -- print()
    -- print("ALLSHAPES")
    -- print(ALLSHAPES)
    -- displayTable1D(ALLSHAPES, 1, NUMALLSHAPES, 1)
    -- print()
    -- print("ALLCOLORS")
    -- print(ALLCOLORS)
    -- displayColorTable(ALLCOLORS, 1, NUMALLCOLORS, 1)
    -- print()

    mainboard = getRandomizedBoard()
    revealedBoxes = generateRevealedBoxesData(false)

end


function love.update(dt)

end


function love.draw() 

end


function  getRandomizedBoard()
    numIconsUsed = BOARDWIDTH * BOARDHEIGHT / 2
    icons = {}
    for i, item in ipairs(ALLCOLORS) do 
        for j, jitem in ipairs(ALLSHAPES) do
            --- icons.insert({item, jitem})
            icon = {item, jitem}
            -- displayIcon(icon)
            -- print()
            table.insert(icons, 1, icon)
        end
    end

    -- displayIconTable(icons, 1, NUMALLCOLORS*NUMALLSHAPES, 1)
    -- print()

    --suffle 
    icons = shuffleTable(icons)

    -- displayIconTable(icons, 1, NUMALLCOLORS*NUMALLSHAPES, 1)
    -- print()

    icons = sliceIconTable(icons, 1, numIconsUsed, 1)
    icons = duplicateIconTables(icons)

    icons = shuffleTable(icons)

    board = {}
    for i = 1, BOARDWIDTH, 1 do 
        column = {}
        for j = 1, BOARDHEIGHT, 1 do 
            table.insert(column, 1, icons[1])
            table.remove(icons, 1)
        end
        table.insert(board, 1, column)
    end

    return board

end


-- https://gist.github.com/Uradamus/10323382
function shuffleTable(tbl)
    for i = #tbl, 2, -1 do
      local j = math.random(i)
      tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
end

function sliceIconTable(tbl, first, last, step)
    local sliced = {}
    for i = first or 1, last or #tbl, step or 1 do
      sliced[#sliced+1] = tbl[i]
    end  
    return sliced
end


function duplicateIconTables(iconstable) 
    output = {}
    for i, item in ipairs(iconstable) do 
        table.insert(output, 1, item)
        table.insert(output, 1, item)
    end
    return output
end 


function generateRevealedBoxesData (value)
    output = {}
    for i = 1, BOARDWIDTH, 1 do
        column = {}
        for j = 1, BOARDHEIGHT, 1 do 
            table.insert(column, 1, value)
        end
        table.insert(output, 1, column)
    end
    return output
end

function love.keypressed(key) 

do


-- functions to display 

function displayTable1D(table, initital, final, step)
    -- local write = io.write
    for i=initital, final, step do 
        io.write(table[i])
        io.write("\t")
    end 
    io.write("\n")

end

function displayColor(color)
    io.write("Color(")
    for i=1, 3, 1 do
        io.write(color[i])
        if i ~= 3 then
            io.write(", ")
        end
    end
    io.write(")")

end 

function displayColorTable(colorTable, initial, final, step)
    io.write("{")
    for i = initial, final, step do 
        displayColor(colorTable[i])
        if i ~= final then
            io.write(", ")
        end
    end 
    io.write("}")

end 

function displayIcon(icon) 
    io.write("Icon(")
    displayColor(icon[1])
    io.write(", ")
    io.write(icon[2])
    io.write(")")
    -- io.write("Icon(", displayColor(icon[0]), ", ", icon[1], ")")
end 

function displayIconTable(iconTable, initial, final, step) 
    io.write("{")
    for i = initial, final, step do 
        displayIcon(iconTable[i])
        if i ~= final then
            io.write(", ")
        end
    end 
    io.write("}")
end


-- DRAW FUNCTIONS 

function drawBoard(mainBoard, revelatedBoard)


end 


function drawIcons(shape, color, boxx, boxy)
    quarter = math.floor(BOXSIZE * 0.25) -- # syntactic sugar
    half =    math.floor(BOXSIZE * 0.5)  -- # syntactic sugar
    
    left = leftCoordsOfBox(boxx, boxy) -- # get pixel coords from board coords
    top  = topCoordsOfBox(boxx, boxy) -- # get pixel coords from board coords
    
    if shape == DONUT then 
        love.graphics.setColor(color)
        love.graphics.circle("fill", left + half, top + half, half - 5)
        love.graphics.setColor(BGCOLOR)
        love.graphics.circle("fill", left + half, top + half, quarter - 5)

    else if shape == SQUARE then 
        love.graphics.setColor(color)
        love.graphics.rectangle("fill", left + quarter, top + quarter, BOXSIZE - half, BOXSIZE - half)

    else if shape == DIAMOND then 
        love.graphics.setColor(color)
        vertices = {
            left + half, top, 
            left + BOXSIZE - 1, top + half, 
            left + half, top + BOXSIZE - 1, 
            left, top + half
        }
        love.graphics.polygon("fill", vertices)

    else if shape == LINES then 
        love.graphics.setColor(color)
        for i = 0, BOXSIZE - 1, 4 do 
            love.graphics.line(left, top + i, left + i, top)
            love.graphics.line(left + i, top + BOXSIZE - 1, left + BOXSIZE - 1, top + i)
        end

    else if shape == OVAL then 
        love.graphics.setColor(color)
        love.graphics.ellipse("fill", left + half, top + half, half, quarter)

    end 
    
end 


function getShapeBoard(board, boxx, boxy) 
    return board[boxx][boxy][2]
end

function getColorBoard(board, boxx, boxy) 
    return board[boxx][boxy][1]
end

function leftCoordsOfBox(boxx, boxy):
    left = boxx * (BOXSIZE + GAPSIZE) + XMARGIN
    return left
end 

function topCoordsOfBox(boxx, boxy):
    top = boxy * (BOXSIZE + GAPSIZE) + YMARGIN
    return top
end 



function hasWon(revealedBoxes)
    for i, item in ipairs(revealedBoxes) do 
        for j, jitem in ipairs(item) do 
            if jitem == false then 
                return false
            end
        end
    end
    return true
end