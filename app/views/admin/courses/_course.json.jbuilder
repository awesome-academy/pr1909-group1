json.extract! course, :id, :course_title, :course_description, :course_type, :course_image,
              :overview_video_url, :created_at, :updated_at
json.url course_url(course, format: :json)
