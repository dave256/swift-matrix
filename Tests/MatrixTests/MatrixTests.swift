import XCTest
// this would allow internal methods/types
//@testable import Matrix

// make certain everything is public
import Matrix

final class Vec3Tests: XCTestCase {
    func testDot() {
        let v1 = Vec3(arrayLiteral: 2, 3, 4)
        let v2 = Vec3(arrayLiteral: 5, 6, 7)
        let r = v1.dot(v2)
        XCTAssertEqual(r, 56)
    }

    func testCross() {
        let v1 = Vec3(arrayLiteral: 2, 3, 4)
        let v2 = Vec3(arrayLiteral: 5, 6, 7)
        let r = v1.cross(v2)
        XCTAssertEqual(r, [-3, 6, -3])
    }
}

final class MatrixTests: XCTestCase {
    func testScaleTranslate() {
        let s = Mat4.scale(sx: 2, sy: 3, sz: 4)
        let t = Mat4.translate(tx: 5, ty: 6, tz: 7)
        let m = t * s
        XCTAssertEqual(m, [[2, 0, 0, 5], [0, 3, 0, 6], [0, 0, 4, 7], [0, 0, 0, 1]])
        let v: Vec3 = [11, 12, 13]
        let r = m * v
        XCTAssertEqual(r.vec3, [27, 42, 59])
    }

    func testTranslateScale() {
        let s = Mat4.scale(sx: 2, sy: 3, sz: 4)
        let t = Mat4.translate(tx: 5, ty: 6, tz: 7)
        let m = s * t
        XCTAssertEqual(m, [[2, 0, 0, 10], [0, 3, 0, 18], [0, 0, 4, 28], [0, 0, 0, 1]])
        let v: Vec3 = [11, 12, 13]
        let r = m * v
        XCTAssertEqual(r.vec3, [32, 54, 80])
    }

    func testLookAt() {
        let eye: Vec3 = [2, 5, 4]
        let coi: Vec3 = [10, 3, 6]
        let m = Mat4.lookAt(eye: eye, coi: coi)
        let r = m * coi
        XCTAssertEqual(r[0], 0.0, accuracy: 0.001)
        XCTAssertEqual(r[1], 0.0, accuracy: 0.001)
        XCTAssertTrue(r[2] < 0.0)
    }

    func testPerspectiveWithLookAt() {
        let eye: Vec3 = [0, 0, 10]
        let coi: Vec3 = [0, 0, 0]
        let lookAt = Mat4.lookAt(eye: eye, coi: coi)
        let near: Vec3 = [0, 0, 9]
        let far: Vec3 = [0, 0, -40]
        let perspective = Mat4.perspectiveProjection(fieldOfViewY: 90, aspectRatio: 1.0, zNear: 1.0, zFar: 50.0)
        let pl = perspective * lookAt
        var r = (pl * near).vec3
        XCTAssertEqual(0, r[0], accuracy: 0.001)
        XCTAssertEqual(0, r[1], accuracy: 0.001)
        XCTAssertEqual(-1, r[2], accuracy: 0.001)
        r = (pl * far).vec3
        XCTAssertEqual(0, r[0], accuracy: 0.001)
        XCTAssertEqual(0, r[1], accuracy: 0.001)
        XCTAssertEqual(1, r[2], accuracy: 0.001)
    }

}
