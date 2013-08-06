require 'digest/sha1'


class GitObject < ActiveRecord::Base

  validates_presence_of :sha1
  validates_uniqueness_of :sha1

  def self.retrieve(content)
    sha1 = calculate_sha1(content)
    return find_by_sha1(sha1) || create(content: content, sha1: sha1)
  end

  def contains?(content)
    sha1 == calculate_sha1(content)
  end

  private

  def self.calculate_sha1(content)
    formatted = "blob #{content.length}\0" + content rescue nil
    return Digest::SHA1.hexdigest(formatted) rescue nil
  end

end
