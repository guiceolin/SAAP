class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "enrollments", "crowds", name: "enrollments_crowd_id_fk"
    add_foreign_key "enrollments", "users", name: "enrollments_student_id_fk", column: "student_id"
    add_foreign_key "enunciations", "crowds", name: "enunciations_crowd_id_fk"
    add_foreign_key "messages_deliveries", "messages_messages", name: "messages_deliveries_message_id_fk", column: "message_id"
    add_foreign_key "messages_deliveries", "users", name: "messages_deliveries_recipient_id_fk", column: "recipient_id"
    add_foreign_key "messages_messages", "users", name: "messages_messages_sender_id_fk", column: "sender_id"
    add_foreign_key "messages_messages", "messages_topics", name: "messages_messages_topic_id_fk", column: "topic_id"
  end
end
