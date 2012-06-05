#!/usr/bin/env ruby
$:.push("#{File.dirname(__FILE__)}/lib")

require 'rubygems'
require 'cgi'
require 'sinatra'
require 'blog_collection'
require 'unis_hanoi'

get '/' do
  form = {
    :file     => '',
    :category => '',
    :folder   => '',
    :year     => '',
    :preview  => true,
  }
  erb :index, :locals => { :form => form, :xml => nil }
end

post '/' do
  error   = false
  preview = false
  xml     = nil

  form = {
    :file     => :error,
    :category => '',
    :folder   => :error,
    :year     => :error,
    :preview  => true,
  }

  # check we've a file
  if params.has_key?('file') && params['file'].has_key?(:tempfile) && !params['file'][:tempfile].nil?
    form[:file] = params['file'][:tempfile]
  else
    error = true
  end

  # check we've the other data
  # re-fill the form hash so we can re-fill it if there's errors or we're previewing
  %w[ category folder year ].each do |data|
    if params.has_key?(data) && !params[data].nil? && !params[data].empty?
      form[data.to_sym] = params[data]
    else
      # category can be blank, others can't
      unless data == 'category'
        error = true
      end
    end
  end

  # are we previewing this time around?
  if params.has_key?('preview') && params['preview'] == 'true'
    preview = true
  end

  unless error
    begin
      bc = BlogCollection.new(form[:file], UnisHanoi.url) do |owner, name|
        owner, name = UnisHanoi.transform(owner, name, form[:year])
      end
      xml = bc.to_opml(form[:folder], form[:category])
      # next time around unlikely to be previewing, clear the checkbox
      form[:preview] = false
    rescue Exception => e
      xml = "Error: " + e.to_s # show the exception as the preview
      preview = true
    end
  end

  if preview || error
    erb :index, :locals => { :form => form, :xml  => xml }
  else
    content_type 'application/xml'
    if params[:category].empty?
      filename = "all-#{params[:folder]}-#{params[:year]}.xml"
    else
      filename = "#{params[:category]}-#{params[:folder]}-#{params[:year]}.xml"
    end
    headers 'Content-Disposition' => %Q[attachment; filename="#{filename}"]
    xml
  end

end

