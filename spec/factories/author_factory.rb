class AuthorFactory
  def self.create(username)
    author = Author.new
    author.username = username
    author.email = "bob@example.com"
    salt = "asdasdastr4325234324sdfds"
    author.salt = salt
    author.password = "secret"
    author.crypted_password = Sorcery::CryptoProviders::BCrypt.
      encrypt("secret", salt)

    author.save
    author
  end
end