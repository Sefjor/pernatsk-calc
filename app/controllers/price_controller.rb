class PriceController < ApplicationController
def show
end
def create
err = 0
input = params[:price][:txt].gsub(/\s+/, "").to_i
if input == 0
input = 23070
err = 1
end #if
ary = Array.new(330, 0)
initprice = 11250
maxprice = initprice * 3
step = 0.1
ct = 0
ctbig = 0
x = 0.0
x = initprice * 0.8
while x <= initprice * 0.9 do
 ct = 30 * ctbig
      dx = (x * step).round 0
       y = x
       t = 0.0

       while y < maxprice 
		t = y
       ary[ct] = t.round 0
       y += dx
       ct += 1
    end
       ctbig += 1
x += initprice * 0.01
end

    pos = -1
    for i in 0..329
	if ary[i] == input
	pos = i
end #if
    end  #for i
if pos == -1
	err = 2
end
    while (pos % 30) != 0
	pos += 1
end #while
	pos -= 1
    while (ary[pos] == 0)
    pos -= 1
    end #while

 case input
  when 9900, 18900, 19800, 29700, 20790 
    err = -1
end

flash[:err] = err
flash[:p] = ary[pos]
flash[:pp] = ary[pos - 1]
redirect_to :back
end
end
