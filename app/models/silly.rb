# encoding: UTF-8
class Silly
  def self.random_success
    lst = %w{huzzah hurrah woot boo-ya olé wheee va-va-voom yay yowza zoinks}
    lst[Random.rand(0...lst.size)]
  end
end
