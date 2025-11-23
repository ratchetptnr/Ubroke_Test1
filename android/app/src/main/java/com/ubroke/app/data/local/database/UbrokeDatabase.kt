package com.ubroke.app.data.local.database

import androidx.room.Database
import androidx.room.RoomDatabase
import androidx.room.TypeConverters
import com.ubroke.app.data.local.dao.ChatDao
import com.ubroke.app.data.local.dao.DocumentDao
import com.ubroke.app.data.local.dao.UserDao
import com.ubroke.app.data.model.ChatMessage
import com.ubroke.app.data.model.UploadedDocument
import com.ubroke.app.data.model.User

@Database(
    entities = [User::class, UploadedDocument::class, ChatMessage::class],
    version = 1,
    exportSchema = false
)
@TypeConverters(Converters::class)
abstract class UbrokeDatabase : RoomDatabase() {
    abstract fun userDao(): UserDao
    abstract fun documentDao(): DocumentDao
    abstract fun chatDao(): ChatDao
}
