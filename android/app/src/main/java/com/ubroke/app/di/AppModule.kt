package com.ubroke.app.di

import android.content.Context
import androidx.room.Room
import com.ubroke.app.data.local.dao.ChatDao
import com.ubroke.app.data.local.dao.DocumentDao
import com.ubroke.app.data.local.dao.UserDao
import com.ubroke.app.data.local.database.UbrokeDatabase
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object AppModule {

    @Provides
    @Singleton
    fun provideDatabase(@ApplicationContext context: Context): UbrokeDatabase {
        return Room.databaseBuilder(
            context,
            UbrokeDatabase::class.java,
            "ubroke_database"
        ).build()
    }

    @Provides
    fun provideUserDao(database: UbrokeDatabase): UserDao = database.userDao()

    @Provides
    fun provideDocumentDao(database: UbrokeDatabase): DocumentDao = database.documentDao()

    @Provides
    fun provideChatDao(database: UbrokeDatabase): ChatDao = database.chatDao()
}
