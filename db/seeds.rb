Board.delete_all
Category.delete_all
Post.delete_all

def lorem(len=nil)
  lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vehicula lorem quis est ultrices, ut ullamcorper nunc iaculis. Aenean posuere enim et massa mattis luctus. Phasellus dignissim augue ipsum, in blandit sem mattis sit amet. Donec tellus neque, varius sed ex in, fermentum porttitor massa."
  len = len ? len : rand(10..lorem.length)
  lorem[rand(0..20), rand(10..275)].lstrip
end

board = Board.create(key: 'sparrow', title: 'Oct. 16 Session')
categories = [ { title:"Something new I learned...", prompt: "Something I'm *grateful* for in the club is...", post_count: 2},
                         { title:"Something I strugged with...", prompt: "Something I struggled with today is...", post_count: 40},
                         { title:"Something awesome I saw someone else doing...", prompt: "Something awesome I saw someone else doing is...", post_count: 12 } ]

categories.each do |c|
  category = Category.create({ board_id: board.id,
                                       title: c[:title],
                                       prompt: c[:prompt] })

  c[:post_count].times do
    Post.create({ category_id: category.id,
                          body: lorem })
  end
end
