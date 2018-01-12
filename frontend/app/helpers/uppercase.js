import { helper } from '@ember/component/helper';

export function uppercase([value]) {
  return value.toUpperCase();
}

export default helper(uppercase);
