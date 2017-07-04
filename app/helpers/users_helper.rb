module UsersHelper
  #returns the Gravatar for the given user
  #takes User object as argument
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    # return image tag <img src=#{gravatar_url} class="gravatar" alt=#{user.full_name} />
    return image_tag(gravatar_url, alt: user.full_name, class: "gravatar")
  end
end
