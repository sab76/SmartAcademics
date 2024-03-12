//
//  Course.swift
//  Smart Academics, Wellness, and Rest Planner


import Foundation
/*
struct Course: Identifiable, Codable {
    let id: Int
    let name: String
    var assignments: [Assignment]
    var priority: Priority // Add the priority property here

    enum Priority: String, Codable, CaseIterable {
        case high = "High"
        case medium = "Medium"
        case low = "Low"
    }

    // will add any other properties and initializers as needed
}*/

struct Course: Codable, Identifiable {
    let id: Int
    let name: String
    let accountId: Int?
    let uuid: String?
    let integrationId: String?
    let sisImportId: Int?
    let sisCourseId: String?
    let courseCode: String?
    let originalName: String?
    let workflowState: String?
    let gradingStandardId: Int?
    let gradePassbackSetting: String?
    let createdAt: Date?
    let startAt: Date?
    let endAt: Date?
    let locale: String?
    let enrollments: [Enrollment]?
    let totalStudents: Int?
    let calendar: Calendar?
    let defaultView: String?
    let syllabusBody: String?
    let needsGradingCount: Int?
    let term: Term?
    let courseProgress: CourseProgress?
    let applyAssignmentGroupWeights: Bool?
    let permissions: Permissions?
    let isPublic: Bool?
    let isPublicToAuthUsers: Bool?
    let publicSyllabus: Bool?
    let publicSyllabusToAuth: Bool?
    let publicDescription: String?
    let storageQuotaMb: Int?
    let storageQuotaUsedMb: Int?
    let hideFinalGrades: Bool?
    let license: String?
    let allowStudentAssignmentEdits: Bool?
    let allowWikiComments: Bool?
    let allowStudentForumAttachments: Bool?
    let openEnrollment: Bool?
    let selfEnrollment: Bool?
    let restrictEnrollmentsToCourseDates: Bool?
    let courseFormat: String?
    let accessRestrictedByDate: Bool?
    let timeZone: String?
    let blueprint: Bool?
    let blueprintRestrictions: BlueprintRestrictions?
    let blueprintRestrictionsByObjectType: [String: BlueprintRestrictions]?
    let template: Bool?
    let enrollmentTermID: Int?
    
    struct Calendar: Codable {
        let ics: String?
    }
    
    struct Enrollment: Codable {
        let type: String?
        let role: String?
        let roleId: Int?
        let userId: Int?
        let enrollmentState: String?
        let limitPrivilegesToCourseSection: Bool?
    }
    
    struct Term: Codable {
        // Add term fields here
    }
    
    struct CourseProgress: Codable {
        // Add course progress fields here
    }
    
    struct Permissions: Codable {
        let createDiscussionTopic: Bool?
        let createAnnouncement: Bool?
    }
    
    struct BlueprintRestrictions: Codable {
        let content: Bool?
        let points: Bool?
        let dueDates: Bool?
        let availabilityDates: Bool?
    }
    
    var priority: Priority = .high// Add the priority property here
    
    enum Priority: String, Codable, CaseIterable {
        case high = "High"
        case medium = "Medium"
        case low = "Low"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, name, accountId = "account_id", uuid, integrationId = "integration_id", sisImportId = "sis_import_id", sisCourseId = "sis_course_id", courseCode = "course_code", originalName = "original_name", workflowState = "workflow_state", gradingStandardId = "grading_standard_id", gradePassbackSetting = "grade_passback_setting", createdAt = "created_at", startAt = "start_at", endAt = "end_at", locale, enrollments, totalStudents = "total_students", calendar, defaultView = "default_view", syllabusBody = "syllabus_body", needsGradingCount = "needs_grading_count", term, courseProgress = "course_progress", applyAssignmentGroupWeights = "apply_assignment_group_weights", permissions, isPublic = "is_public", isPublicToAuthUsers = "is_public_to_auth_users", publicSyllabus = "public_syllabus", publicSyllabusToAuth = "public_syllabus_to_auth", publicDescription = "public_description", storageQuotaMb = "storage_quota_mb", storageQuotaUsedMb = "storage_quota_used_mb", hideFinalGrades = "hide_final_grades", license, allowStudentAssignmentEdits = "allow_student_assignment_edits", allowWikiComments = "allow_wiki_comments", allowStudentForumAttachments = "allow_student_forum_attachments", openEnrollment = "open_enrollment", selfEnrollment = "self_enrollment", restrictEnrollmentsToCourseDates = "restrict_enrollments_to_course_dates", courseFormat = "course_format", accessRestrictedByDate = "access_restricted_by_date", timeZone = "time_zone", blueprint, blueprintRestrictions = "blueprint_restrictions", blueprintRestrictionsByObjectType = "blueprint_restrictions_by_object_type", template, enrollmentTermID = "enrollment_term_id"
    }

    // Define any additional structs needed for nested objects here
}
