#
#  Game of Life class
#
#  Author(s): Brandon Thomas
#
class GameOfLife

    # Creates getter methods for instance variables @rows and @cols
    attr_reader  :rows, :cols

    # Constructor that initializes instance variables with default values
    def initialize()
        @grid = []
        @rows = 0
        @cols = 0
    end

    # Reads data from the file, instantiates the grid, and loads the
    # grid with data from file. Sets @grid, @rows, and
    # @cols instance variables for later use.
    def loadGrid(file)
        data = IO.read(file)
        tokens = data.strip.split(' ')

        @rows = tokens.shift.to_i
        @cols = tokens.shift.to_i

        @grid = Array.new(@rows)
        for i in (0...@cols)
            @grid[i] = Array.new(@rows)
            @grid[i].fill(0)
        end

        for row in 0...@rows do
            for col in 0...@cols do
                @grid[row][col] = tokens.shift.to_i
            end
        end

    end

    # Saves the current grid values to the file specified
    def saveGrid(file)
        data = @rows.to_s + ' ' + @cols.to_s

        for row in 0...@rows do
            for col in 0...@cols do
                data += ' ' + @grid[row][col].to_s
            end
        end

        data += "\n"
        IO.write(file, data)
    end

    def newMod(a, b)
        newNum = a % b

        if (newNum < 0)
            newNum += b
        end

        return newNum
    end

    def DecideCellFate(row, col, neighbors) 
        if (@grid[row][col] == 1 && (neighbors < 2 || neighbors > 3))
            return 0
        elsif (@grid[row][col] == 1 && (neighbors == 2 || neighbors == 3))
            return 1
        elsif (@grid[row][col] == 0 && neighbors == 3)
            return 1
        else
            return @grid[row][col]
        end
    end

    # Mutates the grid to next generation
    def mutate()
        # make a copy of grid and fill it with zeros
        temp = Array.new(@rows)
        for i in (0...@rows)
            temp[i] = Array.new(@cols)
            temp[i].fill(0)
        end

       for row in 0...@rows do
           for col in 0...@cols do
               temp[row][col] = DecideCellFate(row, col, getNeighbors(row, col))
           end
       end

        # DO NOE DELETE: set @grid to temp grid
        @grid = temp
    end

    # Returns the number of neighbors for cell at @grid[i][j]
    def getNeighbors(i, j)
        neighbors = 0

        
		if (@grid[newMod(i - 1, @rows)][j] == 1) 
            neighbors += 1
        end
		if (@grid[newMod(i + 1, @rows)][j] == 1)
            neighbors += 1
        end
		if (@grid[i][newMod(j - 1, @cols)] == 1)
            neighbors += 1
        end
		if (@grid[i][newMod(j + 1, @cols)] == 1)
            neighbors += 1
        end
		if (@grid[newMod(i - 1, @rows)][newMod(j + 1, @cols)] == 1)
            neighbors += 1
        end
		if (@grid[newMod(i + 1, @rows)][newMod(j + 1, @cols)] == 1)
            neighbors += 1
        end
		if (@grid[newMod(i + 1, @rows)][newMod(j - 1, @cols)] == 1)
            neighbors += 1
        end
		if (@grid[newMod(i - 1, @rows)][newMod(j - 1, @cols)] == 1) 
            neighbors += 1
        end

        # DO NOT DELETE THE LINE BELOW
        neighbors
    end

    # Returns a string representation of GameOfLife object
    def to_s
        str = "\n"
        for i in 0...@rows
            for j in 0...@cols
                if @grid[i][j] == 0
                    str += ' . '
                else
                    str += ' X '
                end
            end
            str += "\n"
        end
        str
    end

end
