class CartsController < ApplicationController
#skip_before_filter :verify_authenticity_token
before_action :authenticate_user!, only: [:checkout]
  def index
  @cart = session[:cart] || {}
  end
  def enqry
    @enqry = session[:enqry] || {}
  end

  def add
  id = params[:store_product]
  session[:cart] ||=  {}
  session[:cart][id] = (session[:cart][id] || 0) + 1
  redirect_to(:back)
  end
  def addenqry
  id = params[:store_product]
  session[:enqry] ||=  {}
  session[:enqry][id] = (session[:enqry][id] || 0) + 1
  redirect_to(:back)
  end

  def remove
  id = params[:store_product]
  session[:cart] ||=  {}
  session[:cart][id] = session[:cart][id] - 1
  if (session[:cart][id] == 0)
  session[:cart].except!(id)
  end
  redirect_to(:back)
  end
  def removeenqry
  id = params[:store_product]
  session[:enqry] ||=  {}
  session[:enqry][id] = session[:enqry][id] - 1
  if (session[:enqry][id] == 0)
  session[:enqry].except!(id)
  end
  redirect_to(:back)
  end

  def delivery_address
  end
  def placed
  end
  
  def checkout
  if(current_user.add2 && current_user.add2 != "")
  addr = "#{current_user.add1}"+"\n"+"#{current_user.add2}"
  else if(current_user.add1)
  addr = "#{current_user.add1}"
  end
  end
  if (params[:dcontact] && params[:dcontact] != "")
  addres = "#{params[:dname]}"+"\n"+"#{params[:dadd1]}"+"\n"+"#{params[:dcity]} - "+"#{params[:dzip]}"+"\n"+"#{params[:dstate]}"+"\n"+"Contact: #{params[:dcontact]}"
  else if(current_user.add1)
  addres = "#{current_user.name}"+"\n"+"#{addr}"+"\n"+"#{current_user.city} - "+"#{current_user.zip}"+"\n"+"#{current_user.state}"+"\n"+"Contact: #{current_user.contact}"
  else
  redirect_to checkadd_path
  return
  end
  end
  store = []
  ordervalue = []
  item = []
  freq = []
  spid = []
  pxfS = []
  stotal = []
  cart = session[:cart] || {}
    cart.each do |id, q|
    unless(Product.find(id).store.user == current_user)
    storeid = Product.find(id).store_id
    product = Product.find(id).id
    
    item[storeid] ||= []
    item[storeid] << product
    freq[storeid] ||= []
    freq[storeid][product] = q
    spid[storeid] ||= []
    spid[storeid][product] = id
    pxfS[storeid] ||= []
    pxfS[storeid][product] = Product.find(id).price*q
    stotal[storeid] = (stotal[storeid] || 0) + pxfS[storeid][product]
    if !(store.include?(storeid))       
    store << storeid
    end
    end
    end
    
  store.each do |stored|
   if(stotal[stored] >= Store.find(stored).thrusold)  
    order = Order.new
    order.address = addres
    order.store_id = stored
    order.user_id = current_user.id
    order.bvis = true
    order.svis = true
    order.lvis = true
    order.sresponse = 0
    order.ordervalue = stotal[stored]
    order.save
    item[stored].each do |itemo|
    order_detail = OrderDetail.new
    order_detail.order_id = order.id
    order_detail.product_id = itemo
    order_detail.quantity = freq[stored][itemo]
    order_detail.mrp = pxfS[stored][itemo]/freq[stored][itemo]
    order_detail.save
    session[:cart].delete(spid[stored][itemo])
    end    
    end
  end
   redirect_to order_placed_path
  end

  def sendenqry
  if(current_user.add2 && current_user.add2 != "")
  addr = "#{current_user.add1}"+"\n"+"#{current_user.add2}"
  else if(current_user.add1)
  addr = "#{current_user.add1}"
  end
  end
  if (params[:dcontact] && params[:dcontact] != "")
  addres = "#{params[:dname]}"+"\n"+"#{params[:dadd1]}"+"\n"+"#{params[:dcity]} - "+"#{params[:dzip]}"+"\n"+"#{params[:dstate]}"+"\n"+"Contact: #{params[:dcontact]}"
  else if(current_user.add1)
  addres = "#{current_user.name}"+"\n"+"#{addr}"+"\n"+"#{current_user.city} - "+"#{current_user.zip}"+"\n"+"#{current_user.state}"+"\n"+"Contact: #{current_user.contact}"
  else
  redirect_to checkadd_path
  return
  end
  end
  store = []
  ordervalue = []
  item = []
  freq = []
  spid = []
  pxfS = []
  stotal = []
  cart = session[:enqry] || {}
    cart.each do |id, q|
    unless(Product.find(id).store.user == current_user)
    storeid = Product.find(id).store_id
    product = Product.find(id).id
    
    item[storeid] ||= []
    item[storeid] << product
    freq[storeid] ||= []
    freq[storeid][product] = q
    spid[storeid] ||= []
    spid[storeid][product] = id
    pxfS[storeid] ||= []
    pxfS[storeid][product] = Product.find(id).price*q
    stotal[storeid] = (stotal[storeid] || 0) + pxfS[storeid][product]
    if !(store.include?(storeid))       
    store << storeid
    end
    end
    end
    
  store.each do |stored|
    order = Order.new
    order.address = addres
    order.store_id = stored
    order.user_id = current_user.id
    order.bvis = true
    order.svis = true
    order.lvis = true
    order.sresponse = 0
    order.save
    item[stored].each do |itemo|
    session[:enqry].delete(spid[stored][itemo])
    end
  end
   redirect_to order_placed_path
  end
  
end
