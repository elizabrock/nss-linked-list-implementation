require 'linked_list_item'

class LinkedList
  attr_reader :first_item

  def initialize *args
    args.each do |payload|
      add_item(payload)
    end
  end

  def add_item(payload)
    new_item = LinkedListItem.new(payload)
    if @first_item.nil?
      @first_item = new_item
      return
    end

    last_node.next_list_item = new_item
  end

  def get(n)
    each_linked_list_item_with_index do |linked_list_item, index|
      return linked_list_item.payload if index == n
    end
    raise IndexError, "index #{n} doesn't exist"
  end
  alias [] get

  def last
    node = last_node
    node.payload if node
  end

  def size
    each_linked_list_item_with_index do |item, index|
      return index + 1 if item.last?
    end
    0
  end

  def to_s
    return "| |" unless @first_item

    payloads = []
    each_with_index do |payload, index|
      payloads << payload
    end

    "| #{payloads.join(", ")} |"
  end

  # ========= Bonus ========== #

  # def [](payload)

  # end

  def []=(n, payload)
    get_node(n).payload = payload
  end

  def remove(n)
    if n >= size
      raise IndexError, "cannot remove node at position #{n}, as it does not exist"
    elsif n == 0
      @first_item = @first_item.next_list_item
    else
      before = get_node(n-1)
      node = get_node(n)
      before.next_list_item = node.next_list_item
    end
  end

  # ===== My Implementation ======= #

  # I'm not convinced this is necesary
  def each_with_index
    each_linked_list_item_with_index do |node, index|
      yield node.payload, index
    end
  end

  def each_linked_list_item_with_index
    item = @first_item
    index = 0
    while item
      yield item, index
      item = item.next_list_item
      index = index + 1
    end
  end

  def get_node(n)
    each_linked_list_item_with_index do |lli, index|
      return lli if index == n
    end
  end

  def last_node
    last_node = nil
    each_linked_list_item_with_index do |node, index|
      last_node = node
    end
    last_node
  end

end
