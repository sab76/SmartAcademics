//
//  Assignment.swift
//  Smart Academics, Wellness, and Rest Planner


import Foundation
/*
struct Assignment: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String?
    let createdAt: Date
    let updatedAt: Date
    let dueAt: Date?
    let lockAt: Date?
    let unlockAt: Date?
    let courseId: Int
    let htmlUrl: String
    let submissionsDownloadUrl: String
    let assignmentGroupId: Int

    private enum CodingKeys: String, CodingKey {
        case id, name, description, courseId, htmlUrl, submissionsDownloadUrl, assignmentGroupId
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case dueAt = "due_at"
        case lockAt = "lock_at"
        case unlockAt = "unlock_at"
    }
}
 */

struct ExternalToolTagAttributes: Codable {
    var url: String
    var newTab: Bool
    var resourceLinkId: String

    enum CodingKeys: String, CodingKey {
        case url
        case newTab = "new_tab"
        case resourceLinkId = "resource_link_id"
    }
}

struct LockInfo: Codable {
    var assetString: String
    var unlockAt: Date?
    var lockAt: Date?
    var contextModule: String?
    var manuallyLocked: Bool?

    enum CodingKeys: String, CodingKey {
        case assetString = "asset_string"
        case unlockAt = "unlock_at"
        case lockAt = "lock_at"
        case contextModule = "context_module"
        case manuallyLocked = "manually_locked"
    }
}

struct RubricRating: Codable {
    var points: Int
    var id: String
    var description: String
    var longDescription: String?

    enum CodingKeys: String, CodingKey {
        case points, id, description
        case longDescription = "long_description"
    }
}

struct RubricCriteria: Codable {
    var points: Double
    var id: String?
    var learningOutcomeId: String?
    var vendorGuid: String?
    var description: String?
    var longDescription: String?
    var criterionUseRange: Bool?
    var ratings: [RubricRating]?
    var ignoreForScoring: Bool?

    enum CodingKeys: String, CodingKey {
        case points, id, description
        case learningOutcomeId = "learning_outcome_id"
        case vendorGuid = "vendor_guid"
        case longDescription = "long_description"
        case criterionUseRange = "criterion_use_range"
        case ratings
        case ignoreForScoring = "ignore_for_scoring"
    }
}

struct AssignmentDate: Codable {
    var id: Int?
    var base: Bool?
    var title: String
    var dueAt: Date
    var unlockAt: Date
    var lockAt: Date

    enum CodingKeys: String, CodingKey {
        case id, base, title
        case dueAt = "due_at"
        case unlockAt = "unlock_at"
        case lockAt = "lock_at"
    }
}

struct TurnitinSettings: Codable {
    var originalityReportVisibility: String
    var sPaperCheck: Bool
    var internetCheck: Bool
    var journalCheck: Bool
    var excludeBiblio: Bool
    var excludeQuoted: Bool
    var excludeSmallMatchesType: String
    var excludeSmallMatchesValue: Int

    enum CodingKeys: String, CodingKey {
        case originalityReportVisibility = "originality_report_visibility"
        case sPaperCheck = "s_paper_check"
        case internetCheck = "internet_check"
        case journalCheck = "journal_check"
        case excludeBiblio = "exclude_biblio"
        case excludeQuoted = "exclude_quoted"
        case excludeSmallMatchesType = "exclude_small_matches_type"
        case excludeSmallMatchesValue = "exclude_small_matches_value"
    }
}

struct NeedsGradingCount: Codable {
    var sectionId: String
    var needsGradingCount: Int

    enum CodingKeys: String, CodingKey {
        case sectionId = "section_id"
        case needsGradingCount = "needs_grading_count"
    }
}

struct ScoreStatistic: Codable {
    var min: Double
    var max: Double
    var mean: Double
    var upperQ: Double
    var median: Double
    var lowerQ: Double

    enum CodingKeys: String, CodingKey {
        case min, max, mean
        case upperQ = "upper_q"
        case median
        case lowerQ = "lower_q"
    }
}

struct RubricSettings: Codable {
    var id: Int
    var title: String
    var pointsPossible: Int
    var freeFormCriterionComments: Bool
    var hideScoreTotal: Bool
    var hidePoints: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case pointsPossible = "points_possible"
        case freeFormCriterionComments = "free_form_criterion_comments"
        case hideScoreTotal = "hide_score_total"
        case hidePoints = "hide_points"
    }
}

struct Assignment: Identifiable, Codable {
    var id: Int //
    var name: String //
    var description: String //
    var createdAt: Date //
    var updatedAt: Date //
    var dueAt: Date? //
    var lockAt: Date? //
    var unlockAt: Date? //
    var hasOverrides: Bool?
    var allDates: [AssignmentDate]?
    var courseId: Int //
    var htmlUrl: String //
    var submissionsDownloadUrl: String //
    var assignmentGroupId: Int //
    var dueDateRequired: Bool //
    var allowedExtensions: [String]?
    var maxNameLength: Int //
    var turnitinEnabled: Bool?
    var vericiteEnabled: Bool?
    var turnitinSettings: TurnitinSettings?
    var gradeGroupStudentsIndividually: Bool //
    var externalToolTagAttributes: ExternalToolTagAttributes?
    var peerReviews: Bool //
    var automaticPeerReviews: Bool //
    var peerReviewCount: Int?
    var peerReviewsAssignAt: Date?
    var intraGroupPeerReviews: Bool //
    var groupCategoryId: Int? //
    var needsGradingCount: Int?
    var needsGradingCountBySection: [NeedsGradingCount]?
    var position: Int //
    var postToSis: Bool? //
    var integrationId: String?
    var integrationData: [String: String]?
    var pointsPossible: Double //
    var submissionTypes: [String] //
    var hasSubmittedSubmissions: Bool //
    var gradingType: String //
    var gradingStandardId: Int? //
    var published: Bool //
    var unpublishable: Bool?
    var onlyVisibleToOverrides: Bool //
    var lockedForUser: Bool //
    var lockInfo: LockInfo?
    var lockExplanation: String?
    var quizId: Int?
    var anonymousSubmissions: Bool?
    var discussionTopic: String?
    var freezeOnCopy: Bool?
    var frozen: Bool?
    var frozenAttributes: [String]?
    var submission: String?
    var useRubricForGrading: Bool?
    var rubricSettings: RubricSettings?
    var rubric: [RubricCriteria]?
    var assignmentVisibility: [Int]?
    var overrides: [AssignmentOverride]?
    var omitFromFinalGrade: Bool? //
    var hideInGradebook: Bool? //
    var moderatedGrading: Bool? //
    var graderCount: Int? //
    var finalGraderId: Int? //
    var graderCommentsVisibleToGraders: Bool? //
    var gradersAnonymousToGraders: Bool? //
    var graderNamesVisibleToFinalGrader: Bool? //
    var anonymousGrading: Bool? //
    var allowedAttempts: Int? //
    var postManually: Bool? //
    var scoreStatistics: ScoreStatistic?
    var canSubmit: Bool?
    var abGuid: [String]?
    var annotatableAttachmentId: Int? //
    var anonymizeStudents: Bool? //
    var requireLockdownBrowser: Bool? //
    var importantDates: Bool? //
    var muted: Bool? //
    var anonymousPeerReviews: Bool? //
    var anonymousInstructorAnnotations: Bool? //
    var gradedSubmissionsExist: Bool? //
    var isQuizAssignment: Bool? //
    var inClosedGradingPeriod: Bool? //
    var canDuplicate: Bool? //
    var originalCourseId: Int? //
    var originalAssignmentId: Int? //
    var originalLtiResourceLinkId: Int? //
    var ltiContextID: String? //
    var originalAssignmentName: String? //
    var originalQuizId: Int? //
    var workflowState: String //
    var secureParams: String? //
    var restrictQuantitativeData: Bool? //

    enum CodingKeys: String, CodingKey {
        case id, name, description
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case dueAt = "due_at"
        case lockAt = "lock_at"
        case unlockAt = "unlock_at"
        case hasOverrides = "has_overrides"
        case allDates = "all_dates"
        case courseId = "course_id"
        case htmlUrl = "html_url"
        case submissionsDownloadUrl = "submissions_download_url"
        case assignmentGroupId = "assignment_group_id"
        case dueDateRequired = "due_date_required"
        case allowedExtensions = "allowed_extensions"
        case maxNameLength = "max_name_length"
        case turnitinEnabled = "turnitin_enabled"
        case vericiteEnabled = "vericite_enabled"
        case turnitinSettings = "turnitin_settings"
        case gradeGroupStudentsIndividually = "grade_group_students_individually"
        case externalToolTagAttributes = "external_tool_tag_attributes"
        case peerReviews = "peer_reviews"
        case automaticPeerReviews = "automatic_peer_reviews"
        case peerReviewCount = "peer_review_count"
        case peerReviewsAssignAt = "peer_reviews_assign_at"
        case intraGroupPeerReviews = "intra_group_peer_reviews"
        case groupCategoryId = "group_category_id"
        case needsGradingCount = "needs_grading_count"
        case needsGradingCountBySection = "needs_grading_count_by_section"
        case position
        case postToSis = "post_to_sis"
        case integrationId = "integration_id"
        case integrationData = "integration_data"
        case pointsPossible = "points_possible"
        case submissionTypes = "submission_types"
        case hasSubmittedSubmissions = "has_submitted_submissions"
        case gradingType = "grading_type"
        case gradingStandardId = "grading_standard_id"
        case published
        case unpublishable
        case onlyVisibleToOverrides = "only_visible_to_overrides"
        case lockedForUser = "locked_for_user"
        case lockInfo = "lock_info"
        case lockExplanation = "lock_explanation"
        case quizId = "quiz_id"
        case anonymousSubmissions = "anonymous_submissions"
        case discussionTopic = "discussion_topic"
        case freezeOnCopy = "freeze_on_copy"
        case frozen
        case frozenAttributes = "frozen_attributes"
        case submission
        case useRubricForGrading = "use_rubric_for_grading"
        case rubricSettings = "rubric_settings"
        case rubric
        case assignmentVisibility = "assignment_visibility"
        case overrides
        case omitFromFinalGrade = "omit_from_final_grade"
        case hideInGradebook = "hide_in_gradebook"
        case moderatedGrading = "moderated_grading"
        case graderCount = "grader_count"
        case finalGraderId = "final_grader_id"
        case graderCommentsVisibleToGraders = "grader_comments_visible_to_graders"
        case gradersAnonymousToGraders = "graders_anonymous_to_graders"
        case graderNamesVisibleToFinalGrader = "grader_names_visible_to_final_grader"
        case anonymousGrading = "anonymous_grading"
        case allowedAttempts = "allowed_attempts"
        case postManually = "post_manually"
        case scoreStatistics = "score_statistics"
        case canSubmit = "can_submit"
        case abGuid = "ab_guid"
        case annotatableAttachmentId = "annotatable_attachment_id"
        case anonymizeStudents = "anonymize_students"
        case requireLockdownBrowser = "require_lockdown_browser"
        case importantDates = "important_dates"
        case muted
        case anonymousPeerReviews = "anonymous_peer_reviews"
        case anonymousInstructorAnnotations = "anonymous_instructor_annotations"
        case gradedSubmissionsExist = "graded_submissions_exist"
        case isQuizAssignment = "is_quiz_assignment"
        case inClosedGradingPeriod = "in_closed_grading_period"
        case canDuplicate = "can_duplicate"
        case originalCourseId = "original_course_id"
        case originalAssignmentId = "original_assignment_id"
        case originalLtiResourceLinkId = "original_lti_resource_link_id"
        case originalAssignmentName = "original_assignment_name"
        case originalQuizId = "original_quiz_id"
        case workflowState = "workflow_state"
        case secureParams = "secure_params"
        case ltiContextID = "lti_context_id"
        case restrictQuantitativeData = "restict_quantitative_data"
    }
}

struct AssignmentOverride: Codable, Identifiable {
    var id: Int
    var assignmentId: Int?
    var quizId: Int?
    var contextModuleId: Int?
    var studentIds: [Int]?
    var groupId: Int?
    var courseSectionId: Int?
    var title: String
    var dueAt: Date?
    var allDay: Bool?
    var allDayDate: Date?
    var unlockAt: Date?
    var lockAt: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case assignmentId = "assignment_id"
        case quizId = "quiz_id"
        case contextModuleId = "context_module_id"
        case studentIds = "student_ids"
        case groupId = "group_id"
        case courseSectionId = "course_section_id"
        case title
        case dueAt = "due_at"
        case allDay = "all_day"
        case allDayDate = "all_day_date"
        case unlockAt = "unlock_at"
        case lockAt = "lock_at"
    }
}
