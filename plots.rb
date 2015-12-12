require 'rubyvis'

# vis = Rubyvis::Panel.new do
#   width 150
#   height 150
#   bar do
#     data [1, 1.2, 1.7, 1.5, 0.7, 0.3]
#     width 20
#     height {|d| d * 80}
#     bottom(0)
#     left {index * 25}
#   end
# end

# vis.render
# puts vis.to_svg


def plot_histogram(array)
  require 'rubyvis'

  vis = Rubyvis::Panel.new.width(550).height(550)

  bar = vis.add(pv.Bar).
    data(array).
    width(20).
    height(lambda {|d| (d+0.1) * 20}).
    bottom(0).
    left(lambda {index * 35})


 bar.anchor("top").add(pv.Label).
   text(lambda {|d,t| "#{d}"})
 # bar.anchor("top").add(pv.Label).
 #   text(lambda {"#{parent.index}-#{index}"})

  vis.render
  filename = "plot-#{Time.now.nsec}-#{rand(40)}.svg"
  File.open(filename, "w+") do |f|
    f << vis.to_svg
  end
  filename
end


plot_histogram([12, 6, 18, 11, 2, 0.5, 18, 7, 14, 1])
#plot_histogram([1, 1.2, 1.7, 1.5, 0.7, 0.3])
