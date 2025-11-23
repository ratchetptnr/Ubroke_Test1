package com.ubroke.app.data.local.dao

import androidx.room.*
import com.ubroke.app.data.model.UploadedDocument
import kotlinx.coroutines.flow.Flow

@Dao
interface DocumentDao {
    @Query("SELECT * FROM documents WHERE userId = :userId ORDER BY createdAt DESC")
    fun getDocumentsByUser(userId: String): Flow<List<UploadedDocument>>

    @Query("SELECT * FROM documents WHERE id = :id")
    suspend fun getDocumentById(id: String): UploadedDocument?

    @Query("SELECT * FROM documents WHERE userId = :userId ORDER BY createdAt DESC LIMIT 1")
    suspend fun getLatestDocument(userId: String): UploadedDocument?

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertDocument(document: UploadedDocument)

    @Update
    suspend fun updateDocument(document: UploadedDocument)

    @Delete
    suspend fun deleteDocument(document: UploadedDocument)
}
