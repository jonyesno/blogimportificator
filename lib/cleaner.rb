class Cleaner

	def self.clean(line)
		msg = ""
		csv = nil

		# skip blanks
		if "" == line || line.match(/^\s*$/)
			msg = "blank"
			return [ msg, csv ]
		end

		# skip known headers
		if line.match(/^Contact Group Name:/)
			msg = "contact group header"
			return [ msg, csv ]
		end
		if line.match(/^Members:/)
			msg = "members header"
			return [ msg, csv ]
		end

		# now see if it looks legit
		words = line.split(/\s+/)

		# if last word looks email-like, good
		if words.last.match(/@/)
			msg = "ok"
			csv = %Q{"#{words[0 .. -2].join(' ')}","#{words.last}"}
			return [ msg, csv ]
		end

		# if we've two or more words, then treat the last as the blog name
		if words.length > 1
			msg = "ok"
			csv = %Q{"#{words[0 .. -2].join(' ')}","#{words.last}"}
			return [ msg, csv ]
		end
		# eh?
		msg = "unrecognised"
		return [ msg, csv ]
	end
end
