
unless Category.any?
  @categories = ["Fantasy", "Science Fiction", "Dystopian", "Adventure", "Romance", "Detective & Mystery", "Horror",
                 "Thriller", "Historical Fiction", "Young Adult", "Children’s Fiction", "Memoir & Autobiography",
                 "Biography", "Cooking", "Art & Photography", "Self-Help / Personal Development",
                 "Motivational / Inspirational", "Health & Fitness", "History", "Crafts, Hobbies & Home",
                 "Families & Relationships", "Humor & Entertainment", "Business & Money", "Law & Criminology",
                 "Politics & Social Sciences", "Religion & Spirituality", "Education & Teaching", "Travel", "True Crime"]
  @categories.each do |category|
    Category.find_or_create_by!(name: category)
  end
end

unless User.any?
  10.times do
    FactoryBot.create(:user, :with_books, count: 20)
  end
end

unless Exchange.any?
  User.all.each do |user|
    15.times do
      FactoryBot.create(:exchange, sending_user: user)
    end
  end

  User.all.each do |user|
    15.times do
      FactoryBot.create(:exchange, sending_user: user, receiving_user: nil, process_status: 0)
    end
  end
end

unless Donation.any?
  User.all.each do |user|
    15.times do
      FactoryBot.create(:donation, sending_user: user)
    end
  end

  User.all.each do |user|
    15.times do
      FactoryBot.create(:donation, sending_user: user, receiving_user: nil, process_status: 0)
    end
  end
end

unless Request.any?
  100.times do
    FactoryBot.create(:request)
  end
end

