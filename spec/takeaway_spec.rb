require 'takeaway'
describe Takeaway do
  describe 'can see the menu' do
    let(:subject) { described_class.new(menu) }
    let(:order) { double :order, total_order: [{ dish: "Burger", quantity: 2, price: 10 }],
    final_order: "Order: Burger x 2  Total: £10"
    }
    let(:food) { [{ dish: "Burger", price: 5 }, { dish: "Pizza", price: 7 }] }
    let(:menu) { double :menu, order: order, food_menu: food, 
    show_menu: "#{food[0][:dish]} - £#{food[0][:price]}, #{food[1][:dish]} - £#{food[1][:price]}",
    order_dish: "Ordered - Burger x 1", total_order: [{ dish: "Burger", quantity: 2, price: 10 }]
    }
    it '#see_menu returns menu' do
      expect(subject.see_menu).to eq "Burger - £5, Pizza - £7"
    end
  end
  describe 'ordering' do
    it '#order returns order of dish if available' do
      expect(subject.order("Burger", 1)).to eq "Ordered - Burger x 1"
    end
    it '#order returns error if dish unavailable' do
      expect { subject.order("Sushi", 1) }.to raise_error "Sushi not on the menu"
    end

    it '#check_order returns total order' do
      subject.order("Burger", 1)
      subject.order("Burger", 1)
      expect(subject.check_order).to eq "Order: Burger x 2  Total: £10"
    end

    it '#confirm_order returns error if correct amount not given' do
      expect { subject.confirm_order(1) }.to raise_error "Incorrect amount given"
    end
  end
end
