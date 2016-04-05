class Calendar
  require 'net/http'
  require 'json'

  @base_uri = URI('https://studentservices.uwo.ca/webservices/catalog/index.cfm')
  @username = Rails.application.secrets.calendar_username
  @password = Rails.application.secrets.calendar_password

  def getCourses(subject, catalogNumber, career)

    if catalogNumber.blank?
      params = { :username => @username, :password => @password,
        :subject => subject, :career => career, :command => 'getCourses' }
    else
      params = { :username => @username, :password => @password,
        :subject => subject, :catalogNumber => catalogNumber, :career => career,
        :command => 'getCourses' }
    end

    uri = @base_uri
    uri.query = URI.encode_www_form(params)
    JSON.parse(Net::HTTP.get_response(uri).body)
  end

  def getSubjects(career, term)
    params = { :username => @username, :password => @password,
      :career => career, :term => term, :command => 'getSubjects' }

    uri = @base_uri
    uri.query = URI.encode_www_form(params)
    JSON.parse(Net::HTTP.get_response(uri).body)
  end

end
