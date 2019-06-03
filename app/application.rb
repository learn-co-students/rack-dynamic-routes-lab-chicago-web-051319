require 'pry'

class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    @item_name = req.path.split("/items/").last

    if req.path.match(/items/) && !@@items.find{|item|item.name == @item_name}
    resp.write "Item not found"
    resp.status = 400
    elsif req.path.match(/items/)
      name = @@items.find{|n|n.name == @item_name}
      resp.write name.price if name
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end

end
