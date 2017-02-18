class Robot

  def initialize(w, h)
    @desk = [w, h]
    @pos = [-1, -1]     # Robot position
    @state = nil         # Robot placed == 1
    @direction = 0      # degrees
  end
  
  def read_input(filename = nil)

    if filename && File.exist?(filename)
        input = File.open(filename, 'rb')
    else
        input = ARGF
    end

    input.each do | l |
        exit                                         if l =~ /Q/i
        place l.scan(/[[:word:]]+/)      if l =~ /PLACE/i
        next unless @state
        move                                      if l =~ /move/i
        change_direction -90             if l =~ /left/i
        change_direction 90              if l =~ /right/i
        report                                     if l =~ /report/i
    end
  end
  
  def move
    x, y = @pos[0], @pos[1]
    y = @pos[1] + 1 if @direction == 0
    x = @pos[0] + 1 if @direction == 90
    y = @pos[1] - 1   if @direction == 180
    x = @pos[0] - 1   if @direction == 270
    
    # check for boundaries
    @pos[0] = x if x >= 0 && x < @desk[0]
    @pos[1] = y if y >= 0 && y < @desk[1]
    
  end
  
  def change_direction(degree)
    @direction += degree
    @direction = @direction - 360    if @direction >= 360
    @direction = @direction + 360  if @direction < 0
  end
  
  def place(h)
    return false if h.size < 3
    
    x, y = h[1].to_i, h[2].to_i
    if x >= 0 && x< @desk[0]    &&   y >= 0 && y < @desk[1]
      @pos = [x, y]

      @direction = 0     if h[3] =~ /north/i
      @direction = 90   if h[3] =~ /east/i
      @direction = 180 if h[3] =~ /south/i
      @direction = 270 if h[3] =~ /west/i
      
      @state = 1
    end
  end
  
  def report
    titles = [:NORTH, :EAST,  :SOUTH, :WEST ]
    status = sprintf "%d,%d,%s", @pos[0], @pos[1], titles[@direction/90]
    puts status
    status
  end

end