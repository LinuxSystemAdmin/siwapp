FactoryGirl.define do

  factory :item do
    transient do
      with_retention false
    end

    sequence :description do |n|
      "Item example description #{n}"
    end
    quantity 5
    unitary_cost 3.33
    discount 0
    common

    factory :item_complete do
      after(:create) do |item, evaluator|
        vat = Tax.find_by(default: true) || create(:tax)
        item.taxes << vat
        if evaluator.with_retention
          item.taxes << (Tax.find_by(name: 'RETENTION') || create(:tax_retention))
        end
      end
    end
  end

  factory :item_random, class: Item do
    quantity { rand(1..10) }
    unitary_cost { BigDecimal(rand(1..100.0).round(2).to_s) }
    discount { [0, 0, 0, 0, 10, 20].sample }
    description {[
                  'Weird shoe lazes',
                  'Drowning kit',
                  'Personal Drone',
                  'Paper',
                  'Fishing kit'].sample}

    after(:create) do |item|
      vat = Tax.find_by(default: true) || create(:tax)
      item.taxes << vat
      if [true, false].sample
        irpf = Tax.find_by(name: 'RETENTION') || create(:tax_retention)
        item.taxes << irpf
      end
    end
  end

end
