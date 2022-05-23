
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
    FactoryBot.create(:user, :with_books, count: 5)
  end
end

unless Exchange.any?
  20.times do
    FactoryBot.create(:exchange)
  end
end

unless Donation.any?
  20.times do
    FactoryBot.create(:donation)
  end
end

