require 'rmagick'
require 'prime'

#N = 700; W = 5 # large
N = 50; W = 10 # small

Background = '#F0F0F0'; Foregrand = '#86D360' # github
#Background = '#E9EAED'; Foregrand = '#415E9B' # facebook
#Background = 'white'; Foregrand = 'black'

# stolen from http://rosettacode.org/wiki/Ulam_spiral_(for_primes)#Ruby
def cell(x, y, start=1)
  y, x = y - N/2, x - (N - 1)/2
  l = 2 * [x.abs, y.abs].max
  d = y >= x ? l*3 + x + y : l - x - y
  (l - 1)**2 + d + start - 1
end

def main
  canvas = Magick::Image.new(N*W, N*W) { self.background_color = Background }
  gc = Magick::Draw.new
  gc.fill(Foregrand)

  N.times do |y|
    N.times do |x|
      n = cell(x, y)

      if n.prime?
        xx = x * W
        yy = y * W
        gc.polygon(xx, yy,
                   xx + W, yy,
                   xx + W, yy + W,
                   xx, yy + W)
      end
    end
  end

  gc.draw(canvas)

  canvas.write("ulam#{N}.png")
end

main
